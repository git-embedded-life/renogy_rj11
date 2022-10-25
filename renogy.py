#!/usr/bin/python3

import RPi.GPIO as GPIO
import time
from enum import Enum
import sys
import subprocess
import secrets
import threading
from datetime import datetime


AC_INV_PIN = 24
FAULT_PIN = 23
FLASH_TIMEOUT_S = 2
# When in off state, input should be a constant 1 (BJT inverses everything)
LED_ON = 0
LED_OFF = 1
RUNTIME = 45*60


class Pin_State():
    state_strings = {
        "_state_OFF": "OFF",
        "_state_FLASH": "FLASH",
        "_state_ON": "ON"
    }

    def __init__(self):
        self.state_fn = self._state_OFF
        self.previous_led_on_off = None
        self.led_on_off = None
        self.timestamp = None
        return

    def _state_OFF(self):
        if self.led_on_off == LED_ON:
            self.state_fn = self._state_FLASH

        return

    def _state_FLASH(self):
        if self.timestamp == None or self.previous_led_on_off != self.led_on_off:
            self.timestamp = time.time()
            return

        if time.time() - self.timestamp > FLASH_TIMEOUT_S:
            if self.led_on_off == LED_ON:
                self.state_fn = self._state_ON
            else:
                self.state_fn = self._state_OFF

            self.timestamp = None

            return

        return

    def _state_ON(self):
        if self.led_on_off == LED_OFF:
            self.state_fn = self._state_FLASH
        return

    def run(self, led_on_off):
        self.previous_led_on_off = self.led_on_off
        self.led_on_off = led_on_off
        # Run the function currently pointed to by state
        self.state_fn()
        return

    def get_state(self):
        return Pin_State.state_strings[self.state_fn.__name__]


class UPS():
    class State(Enum):
        OFF = 0
        ONLINE = 1
        ON_BATTERY = 2
        LOW_BATTERY = 3
        FAULT = 4

    def __init__(self):
        self._state = UPS.State.OFF
        self._last_read_state = None
        self._ups_status = "OL"
        self._battery_runtime = RUNTIME
        self._power_loss_time = None

    def run(self, ac_inv_state, fault_state):
        if fault_state == "ON" or fault_state == "FLASH":
            if self._state != UPS.State.FAULT:
                self._state = UPS.State.FAULT
                self._ups_status = "OB LB"
                self._battery_runtime = 0

        elif ac_inv_state == "ON":
            if self._state != UPS.State.ONLINE:
                self._state = UPS.State.ONLINE
                self._ups_status = "OL"
                self._battery_runtime = RUNTIME
                self._power_loss_time = None

        elif ac_inv_state == "OFF":
            if self._state != UPS.State.OFF:
                self._state = UPS.State.OFF
                self._ups_status = "OL"
                self._battery_runtime = 0

        elif ac_inv_state == "FLASH":
            if self._power_loss_time == None:
                self._power_loss_time = time.time()

            self._battery_runtime = RUNTIME - int(time.time() - self._power_loss_time)

            if self._battery_runtime <= 0:
                self._battery_runtime = 0

                if self._state != UPS.State.LOW_BATTERY:
                    self._state = UPS.State.LOW_BATTERY
                    self._ups_status = "OB LB"

                return
                
            if self._state != UPS.State.ON_BATTERY:
                self._state = UPS.State.ON_BATTERY
                self._ups_status = "OB"

    @property
    def ups_status(self):
        return self._ups_status

    @property
    def battery_runtime(self):
        return self._battery_runtime

    @property
    def get_state_if_changed(self):
        if self._last_read_state == self._state:
            return None

        self._last_read_state = self._state
        return self._state


def _led_daemon(ac_inv, fault):
    while True:
        ac_inv.run(GPIO.input(AC_INV_PIN))
        fault.run(GPIO.input(FAULT_PIN))
        time.sleep(.2)

def main():
    GPIO.setmode(GPIO.BCM)
    GPIO.setup([AC_INV_PIN, FAULT_PIN], GPIO.IN)

    ac_inv = Pin_State()
    fault = Pin_State()
    ups = UPS()

    led_daemon = threading.Thread(target=_led_daemon, args=(ac_inv, fault, ), daemon=True)
    led_daemon.start()

    while True:
        ups.run(ac_inv.get_state(), fault.get_state())

        state = ups.get_state_if_changed
        if state is not None:
            print("State: {}, Status: {}, Runtime: {}, AC_INV: {}, FAULT: {}".format(state.name if state else "None", ups.ups_status, ups.battery_runtime, ac_inv.get_state(), fault.get_state()), flush=True)

        if "SUCCESS" not in subprocess.run(["/usr/local/ups/bin/upsrw", "-w", "-u", "renogy_py", "-p", secrets.nut_pw, "-s", "battery.runtime={}".format(ups.battery_runtime), "renogy"], capture_output=True).stderr.decode():
            print("Error writing to battery.runtime")

        if "SUCCESS" not in subprocess.run(["/usr/local/ups/bin/upsrw", "-w", "-u", "renogy_py", "-p", secrets.nut_pw, "-s", "ups.status={}".format(ups.ups_status), "renogy"], capture_output=True).stderr.decode():
            print("Error writing to ups.status")

        time.sleep(2)

if __name__ == '__main__':
    sys.exit(main())