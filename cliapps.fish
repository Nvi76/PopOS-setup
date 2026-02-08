#!/usr/bin/env fish

# Exit on error (Fish way)
function fish_command_not_found
    echo "Script failed. Exiting."
    exit 1
end

# Update system
sudo nala update -y
or exit 1

sudo nala upgrade -y
or exit 1

# Install Atuin
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
or exit 1

# Setup Fish config directory
mkdir -p ~/.config/fish

# Config file path
set config_file ~/.config/fish/config.fish

# Append Atuin config if missing
if not grep -q "atuin init fish" $config_file ^/dev/null

    cat >> $config_file <<EOF

# Atuin setup
if status is-interactive
    set -gx ATUIN_NOBIND true
    atuin init fish | source
    bind \cr _atuin_search
    bind -M insert \cr _atuin_search
end
EOF

end

# Install Homebrew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
or exit 1

# Add Homebrew to PATH
if not grep -q "brew shellenv" $config_file ^/dev/null
    echo "" >> $config_file
    echo 'eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> $config_file
end

# Apply brew env
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# Reload config
source ~/.config/fish/config.fish

# Done
echo "Installation Complete"
