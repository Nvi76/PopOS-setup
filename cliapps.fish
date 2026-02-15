#!/usr/bin/env fish

# Add luanti's PPA
sudo add-apt-repository ppa:minetestdevs/stable -y; or exit 1

# Import Brave keyring
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg; or exit 1

# Add Brave repo
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
| sudo tee /etc/apt/sources.list.d/brave-browser-release.list >/dev/null; or exit 1

# Import VSCodium keyring
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
| gpg --dearmor \
| sudo tee /usr/share/keyrings/vscodium-archive-keyring.gpg >/dev/null; or exit 1

# Add VSCodium repo
printf "Types: deb
URIs: https://download.vscodium.com/debs
Suites: vscodium
Components: main
Architectures: amd64 arm64
Signed-by: /usr/share/keyrings/vscodium-archive-keyring.gpg
" | sudo tee /etc/apt/sources.list.d/vscodium.sources >/dev/null; or exit 1

# Update system
sudo nala update; or exit 1
sudo nala upgrade -y; or exit 1

# Install Cliapps
sudo nala install -y figlet fish curl git vulkan-tools os-prober build-essential python3-tk python3-distutils-extra pipx mesa-utils gnupg wl-clipboard cava; or exit 1

# Install Atuin
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh; or exit 1

# Setup Fish config directory
mkdir -p ~/.config/fish

# Config file path
set config_file ~/.config/fish/config.fish
touch $config_file

# Append Atuin config if missing
if not grep -q "atuin init fish" $config_file 2>/dev/null

    printf '

# Atuin setup
if status is-interactive
    set -gx ATUIN_NOBIND true
    atuin init fish | source
    bind \cr _atuin_search
    bind -M insert \cr _atuin_search
end
' >> $config_file

end

# Install Homebrew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash; or exit 1

# Ensure the config directory exists
if not test -d ~/.config/fish
    mkdir -p ~/.config/fish
end

# Append the Homebrew setup to Fish config
echo 'eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)' >> ~/.config/fish/config.fish

# Evaluate the Homebrew environment in the current session
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)   

# Apply brew env
/home/linuxbrew/.linuxbrew/bin/brew shellenv | source

# Reload config
source ~/.config/fish/config.fish

# Done
figlet "Setup Complete" 2>/dev/null; or echo "Setup Complete"
