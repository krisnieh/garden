#!/bin/bash

# bios_id=$(sudo dmidecode -s system-serial-number)
line="a"
unit_id=1

hostname="hsf-working_line-${line}-${unit_id}"

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

# 停止并禁用自动更新服务
systemctl stop apt-daily.service
systemctl stop apt-daily.timer
systemctl stop apt-daily-upgrade.timer
systemctl stop apt-daily-upgrade.service

systemctl disable apt-daily.service
systemctl disable apt-daily.timer
systemctl disable apt-daily-upgrade.timer
systemctl disable apt-daily-upgrade.service

# 禁用更新管理器的自动更新检查
echo 'APT::Periodic::Update-Package-Lists "0";' > /etc/apt/apt.conf.d/20auto-upgrades
echo 'APT::Periodic::Download-Upgradeable-Packages "0";' >> /etc/apt/apt.conf.d/20auto-upgrades
echo 'APT::Periodic::AutocleanInterval "0";' >> /etc/apt/apt.conf.d/20auto-upgrades
echo 'APT::Periodic::Unattended-Upgrade "0";' >> /etc/apt/apt.conf.d/20auto-upgrades

# 禁用Unattended-Upgrades
apt remove -y unattended-upgrades

# 禁用更新通知
gsettings set com.ubuntu.update-notifier no-show-notifications true

# 配置软件更新首选项
echo 'Unattended-Upgrade::Allowed-Origins {};' > /etc/apt/apt.conf.d/51unattended-upgrades-local

# 禁用release升级提示
sed -i 's/Prompt=.*/Prompt=never/' /etc/update-manager/release-upgrades

echo "已成功禁用所有自动更新和更新提示"