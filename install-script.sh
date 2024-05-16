#!/bin/bash
# This script is supposed to run on the SBC post install
# Must run as root

# https://github.com/jschmid1/gopro_as_webcam_on_linux/commits/master/
TARGET_COMMIT="8c423fa1936493662ff7d747ec8dbdd1ea5a74bc"

# ---------------------------------
# Dependencies
apt update
apt install -y git ffmpeg v4l2loopback-dkms raspberrypi-kernel-headers curl vlc

# ---------------------------------
# Files
cat <<EOF >/etc/network/interfaces.d/usb0.conf
allow-hotplug usb0
iface usb0 inet dhcp
EOF

cat <<EOF >/etc/systemd/system/gopro_webcam.service
[Unit]
Description=GoPro Webcam start script
After=network-online.target
Wants=network-online.target systemd-networkd-wait-online.service
StartLimitIntervalSec=0

[Service]
ExecStart=/bin/gopro webcam -a -n -f linear -p usb
Restart=always
RestartSec=10s

[Install]
WantedBy=multi-user.target
EOF

cat <<EOF >/lib/udev/rules.d/60-gopro.rules
SUBSYSTEM=="usb", ATTRS{idVendor}=="2672", ENV{ID_USB_MODEL}=="HERO8_BLACK", ACTION=="add", RUN+="systemctl start gopro_webcam"
SUBSYSTEM=="usb", ATTRS{idVendor}=="2672", ENV{ID_USB_MODEL}=="HERO8_BLACK", ACTION=="remove", RUN+="systemctl stop gopro_webcam"
EOF

# ---------------------------------
# Webcam script
wget https://raw.githubusercontent.com/jschmid1/gopro_as_webcam_on_linux/$TARGET_COMMIT/gopro -O /var/tmp/gopro
install -D /var/tmp/gopro /bin/gopro