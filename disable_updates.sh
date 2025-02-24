#!/bin/bash

# 需要root权限运行此脚本
if [ "$EUID" -ne 0 ]; then 
    echo "请使用sudo运行此脚本"
    exit 1
fi

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