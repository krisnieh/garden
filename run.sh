#!/bin/bash

# bios_id=$(sudo dmidecode -s system-serial-number)
terminal_id=1
line="a"
unit_id=1

hostname="terminal-wl-${line}-${unit_id}"

sudo cp logo_start.png /usr/share/plymouth/themes/spinner/watermark.png 

sudo apt update
sudo apt install -y vim git
git config --global user.name "kris"
git config --global user.email "kris@example.com"

# sudo nmcli con mod wlp1s0 ipv4.method manual ipv4.addresses 172.16.22.$terminal_id/16 ipv4.gateway 172.16.0.1 ipv4.dns 172.16.0.1
# sudo nmcli con down wlp1s0
# sudo nmcli con up wlp1s0

sudo dpkg -i winter_1.0.0_amd64.deb


mkdir -p ~/.config/autostart

cat > ~/.config/autostart/winter.desktop  <<EOF
[Desktop Entry]
Type=Application
Exec=/usr/local/lib/winter/winter
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=HSF
Name=HSF
Comment[en_US]=Henjou Smart Factory
Comment=恒久智慧工厂

EOF

