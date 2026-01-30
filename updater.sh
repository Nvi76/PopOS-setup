#!/bin/bash

set -euo pipefail

# Updates the system
sudo apt update -y && sudo apt upgrade -y

# Updating flatpak apps
flatpak update 

# Updating Atuin
atuin-update 

# Updating Homebrew
brew update && brew upgrade

# Updating hblock
curl -o /tmp/hblock 'https://raw.githubusercontent.com/hectorm/hblock/v3.5.1/hblock' \
  && echo 'd010cb9e0f3c644e9df3bfb387f42f7dbbffbbd481fb50c32683bbe71f994451  /tmp/hblock' | shasum -c \
  && sudo mv /tmp/hblock /usr/local/bin/hblock \
  && sudo chown 0:0 /usr/local/bin/hblock \
  && sudo chmod 755 /usr/local/bin/hblock && hblock 

# Updating clamav
sudo freshclam
