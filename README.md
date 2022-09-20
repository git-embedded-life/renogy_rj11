# Intro
I have a Renogy Pure Sine Wave Inverter/Charger that I use to power my sump pump and server during a power outage. Recently I moved the inverter/charger from the basement to the garage which made my previous project of reading the display obsolete because I didn't want to suspend a Pi in front of the display only to have it bumped when somebody walked by. I still needed a way for the inverter to notify the attached computer when it was on battery, and when the battery was "low" so it could shut down cleanly.

The Renogy has a RJ11 port on it to connect a wired remote to. The remote has two LEDs on it: a green one that is solid when there is wall power, flashing when it is on battery, and a red one for error states. I figured I could reverse engineer this connection and use this port for the information I need. 

While with this I only will get On Wall/On Battery, I can make it work. The priority is the sump pump, so when power is lost I only want the computer to be up for a short period of time so most of the power is reserved for the sump pump. I just use a timer that is started when power is lost before reporting low battery.

# Setup

I use a NUT dummy UPS that from within the Python script it runs a NUT binary that updates the values of the dummy UPS. NUT 2.8 or higher is required for this and is not included in teh apt repo so I pulled it down from source.

## NUT Installation

```
# https://networkupstools.org/docs/user-manual.chunked/ar01s05.html

git clone https://github.com/networkupstools/nut.git
sudo useradd -r nut
sudo apt install autoconf automake libtool libssl-dev
./autogen.sh
./configure --with-user=nut --with-group=nut --without-nut-scanner --with-ssl --without-serial
make
sudo make install
mkdir -p /var/state/ups
sudo chmod 0770 /var/state/ups
sudo chown root:nut /var/state/ups
cp /usr/local/ups/etc/ups.conf.sample /usr/local/ups/etc/ups.conf
cp /usr/local/ups/etc/upsd.conf.sample /usr/local/ups/etc/upsd.conf
cp /usr/local/ups/etc/upsd.users.sample /usr/local/ups/etc/upsd.users
sudo chmod 640 /usr/local/ups/etc/upsd.users /usr/local/ups/etc/upsd.conf

# added 0.0.0.0 to /usr/local/ups/etc/upsd.conf

# enabled all nut unit files in /lib/systemd/system
```

/usr/local/ups/etc/ups.conf
```
[renogy]
        driver = dummy-ups
        port = renogy.dev
        # dummy-once is avaiable in 2.8.0 and prevents upsd from
        # overwritting values manipulated by upsrw
        mode = dummy-once
        desc = "Renogy UPS"
```

/usr/local/ups/etc/renogy.dev
```
device.mfr: Renogy
device.model: R-INVT-PCL1-30111S-US
device.type: ups
ups.mfr: Renogy
ups.model: R-INVT-PCL1-30111S-US
ups.status: OL
battery.runtime: 0
```