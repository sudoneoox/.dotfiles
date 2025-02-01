#!/bin/bash
# Set colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Package groups
TIME_SYNC=("ntp" "chrony")

UTILS=("xorg" "xorg-xinit" "xterm" "git" "polkit" "polkit-gnome" "alsa-utils"
  "pavucontrol" "pipewire" "pipewire-pulse" "pipewire-alsa"
  "arandr" "at" "acpi" "git" "brightnessctl" "rsync" "node" "network-manager-applet" "volctl" "playerctl" "awesome-luajit-git" "flameshot" 
  "clipmenu-rofi" "blueman" "maim" "i3lock-color" "nitrogen" "rofimoji" "cups" "btop" "bat" "fzf" "tldr" "wget")

THEMES=("lxappearance" "qt5ct" "kvantum" "pop-theme" "papirus-icon-theme" "pop-theme")

FONT_PACKAGES=("ttf-iosevka-nerd" "ttf-mononoki-nerd" "ttf-roboto" "ttf-fira-mono" "noto-fonts-emoji")

NVIM_CONFIG=(
  "python-cpplint" "clang" "python-sqlfluff" "nodejs" "npm" "lua-language-server" "lazygit" "ruby" "neovim-tree-sitter-git" "lldb" "lazygit" "fd" "ripgrep"
)

APPLICATIONS=("localsend-bin" "rofi" "spotify" "filelight" "neovim" "zen-browser-bin" "discord" "obsidian")


DEPENDENCY_PACKAGES=(
  ${UTILS[*]} ${NVIM_CONFIG[*]} ${TIME_SYNC[*]}
)

ETC_PACKAGES=(
  ${APPLICATIONS[*]} ${THEMES[*]} ${FONT_PACKAGES[*]}
)

# Function to display the main menu
display_main_menu() {
  echo -e "${YELLOW}Install Packages?:${NC}"
}

# Function to get user selection
get_selection() {
  local selection
  read -p "Enter your choice (y/n): " selection
  echo $selection
}

# Function to setup time synchronization
setup_time_sync() {
  echo -e "${GREEN}Setting up time synchronization...${NC}"
  # Enable and start NTP service
  sudo timedatectl set-ntp true
  sudo systemctl enable --now chronyd
  # Wait for initial sync
  sleep 2
  # Show sync status
  timedatectl status
}

# Function to install core packages
install_packages() {
  echo -e "${GREEN}Installing core packages...${NC}"
  yay -S --needed ${DEPENDENCY_PACKAGES[*]}
  yay -S --needed ${ETC_PACKAGES[*]}
  sudo npm i -g eslint vim-language-server tree-sitter-cli neovim
  
  # Setup time synchronization
  setup_time_sync
  
  echo -e "${GREEN}Installing Arc icons...${NC}"
  git clone https://github.com/horst3180/arc-icon-theme --depth 1 && cd arc-icon-theme
  ./autogen.sh --prefix=/usr
  sudo make install
  cd .. && rm -rf arc-icon-theme
  wget micro.mamba.pm/install.sh && chmod +x install.sh && ./install.sh && rm install.sh
}

# Main script logic
main() {
  while true; do
    display_main_menu
    selection=$(get_selection)
    case $selection in
      y)
        install_packages
        ;;
      n)
        echo "Exiting..."
        exit 0
        ;;
      *)
        echo -e "${RED}Invalid selection.${NC}"
        ;;
    esac
  done
}

main
