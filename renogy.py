#!/usr/bin/python3

import RPi.GPIO as GPIO
import time
from enum import Enum
import sys
import subprocess
import secrets
import threading


AC_INV_PIN = 23
FAULT_PIN = 24
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
        print("Init State to ON")
        self.state = self._state_ON
        self.previous_led_on_off = None
        self.led_on_off = None
        self.timestamp = None
        return

    def _state_OFF(self):
        if self.led_on_off == LED_ON:
            print("State - FLASH")
            self.state = self._state_FLASH

        return

    def _state_FLASH(self):
        if self.timestamp == None or self.previous_led_on_off != self.led_on_off:
            self.timestamp = time.time()
            return

        if time.time() - self.timestamp > FLASH_TIMEOUT_S:
            if self.led_on_off == LED_ON:
                self.state = self._state_ON
                print("State - ON")
            else:
                self.state = self._state_OFF
                print("State - OFF")

            self.timestamp = None

            return

        return

    def _state_ON(self):
        if self.led_on_off == LED_OFF:
            self.state = self._state_FLASH
            print("State - FLASH")
        return

    def run(self, led_on_off):
        self.previous_led_on_off = self.led_on_off
        self.led_on_off = led_on_off
        # Run the function currently pointed to by state
        self.state()
        return

    def get_state(self):
        return Pin_State.state_strings[self.state.__name__]


class UPS():
    def __init__(self):
        self._input_voltage = 0
        self._output_voltage = 0
        self._ups_status = "OL"
        self._battery_runtime = 0
        self._power_loss_time = None

    def ups_state(self, state):
        if state == "ON":
            self._input_voltage = 120
            self._output_voltage = 120
            self._ups_status = "OL"
            self._battery_runtime = RUNTIME
            self._power_loss_time = None
        elif state == "OFF":
            self._output_voltage = 0
        elif state == "FLASH":
            if self._power_loss_time == None:
                self._power_loss_time = time.time()

            self._input_voltage = 0
            self._output_voltage = 120
            self._ups_status = "OB"
            # self._ups_status = "OL"
            self._battery_runtime = RUNTIME - int(time.time() - self._power_loss_time)

            if self._battery_runtime <= 0:
                self._battery_runtime = 0
                self._ups_status = "OB LB"
                # self._ups_status = "OL"

    @property
    def input_voltage(self):
        return self._input_voltage

    @property
    def output_voltage(self):
        return self._output_voltage

    @property
    def ups_status(self):
        return self._ups_status

    @property
    def battery_runtime(self):
        return self._battery_runtime

def _led_daemon(ac_inv):
    while True:
        ac_inv.run(GPIO.input(AC_INV_PIN))
        time.sleep(.2)

def main():
    GPIO.setmode(GPIO.BCM)
    GPIO.setup([AC_INV_PIN, FAULT_PIN], GPIO.IN)

    ac_inv = Pin_State()
    ups = UPS()

    led_daemon = threading.Thread(target=_led_daemon, args=(ac_inv,), daemon=True)
    led_daemon.start()

    while True:
        ups.ups_state(ac_inv.get_state())

        print("In Volt: {}, Out Volt: {}, Runtime: {}, State: {}".format(ups.input_voltage, ups.output_voltage, ups.battery_runtime, ups.ups_status), flush=True)
        
        # if "SUCCESS" not in subprocess.run(["/usr/local/ups/bin/upsrw", "-w", "-u", "renogy_py", "-p", secrets.nut_pw, "-s", "input.voltage={}".format(ups.input_voltage), "renogy"], capture_output=True).stderr.decode():
        #     print("Error writing to input.voltage")

        # if "SUCCESS" not in subprocess.run(["/usr/local/ups/bin/upsrw", "-w", "-u", "renogy_py", "-p", secrets.nut_pw, "-s", "output.voltage={}".format(ups.output_voltage), "renogy"], capture_output=True).stderr.decode():
        #     print("Error writing to output.voltage")

        if "SUCCESS" not in subprocess.run(["/usr/local/ups/bin/upsrw", "-w", "-u", "renogy_py", "-p", secrets.nut_pw, "-s", "battery.runtime={}".format(ups.battery_runtime), "renogy"], capture_output=True).stderr.decode():
            print("Error writing to battery.runtime")

        if "SUCCESS" not in subprocess.run(["/usr/local/ups/bin/upsrw", "-w", "-u", "renogy_py", "-p", secrets.nut_pw, "-s", "ups.status={}".format(ups.ups_status), "renogy"], capture_output=True).stderr.decode():
            print("Error writing to ups.status")

        time.sleep(2)

if __name__ == '__main__':
    sys.exit(main())