#!/bin/bash

set -euo pipefail

# Copying hosts file
sudo cp /etc/hosts ~/linuxmintsetup 

# Downloading safing portmaster
curl https://updates.safing.io/latest/linux_amd64/packages/portmaster-installer.deb --output portmaster.deb

# Installing essential packages
sudo apt install build-essential nala fish curl git

# Installing security apps
sudo nala install fail2ban clamav -y && sudo nala install ./portmaster.deb -y && sudo nano /etc/fail2ban/jail.local && sudo systemctl restart fail2ban 

# Enabling services
sudo systemctl start fail2ban && sudo systemctl enable fail2ban

# Updating Clamav
sudo rm /var/log/clamav/freshclam.log && sudo freshclam

# Changing to fish shell
chsh -s /usr/bin/fish
