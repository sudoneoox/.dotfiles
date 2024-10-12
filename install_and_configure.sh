#!/bin/bash

# Set colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Define package lists
DEPENDENCY_PACKAGES=(
  "xorg" "xorg-xinit" "xterm" "git" "polkit" "polkit-gnome" "alsa-utils"
  "pavucontrol" "pipewire" "pipewire-pulse" "pipewire-alsa"
  "arandr" "at" "acpi" "git" "brightnessctl" "rsync"
)

AUR_PACKAGES=(
  "picom-git" "network-manager-applet" "volctl" "rofi" "lxappearance" "qt5ct"
  "kvantum" "pop-theme" "mugshot" "papirus-icon-theme" "awesome-luajit-git" "playerctl"
  "flameshot" "clipmenu-rofi" "blueman" "rofi" "clipmenu-rofi" "maim" "i3lock-color"
  "nitrogen" "playerctl" "localsend-bin"
)

FONT_PACKAGES=(
  "ttf-iosevka-nerd" "ttf-mononoki-nerd" "ttf-roboto" "ttf-fira-mono"
)

CORE_PACKAGES=(
  "webkit2gtk-4.1" "networkmanager-openconnect" "cups"
  "btop" "bat" "filelight" "syncthing" "neovim" "tldr" "firefox" "discord"
)

NVIM_CONFIG=(
  "python-cpplint" "clang" "python-sqlfluff" "nodejs" "npm" "lua-language-server" "lazygit" "ruby" "neovim-tree-sitter-git" "lldb" "lazygit" "fd"
 
)

# Function to display the main menu
display_main_menu() {
  echo -e "${YELLOW}Select an action:${NC}"
  echo "1) Install dependency packages"
  echo "2) Install fonts"
  echo "3) Install Arc icons"
  echo "4) Install core packages"
  echo "5) Install all"
  echo "6) Exit"
}

# Function to get user selection
get_selection() {
  local selection
  read -p "Enter your choice: " selection
  echo $selection
}

# Function to install core packages
install_dependency_packages() {
  echo -e "${GREEN}Installing core packages...${NC}"
  sudo pacman -S --needed "${DEPENDENCY_PACKAGES[@]}"
  yay -S --needed "${NVIM_CONFIG[@]}"
  sudo npm i -g eslint
  yay -S --needed "${DEPENDENCY_PACKAGES[@]}"
  sudo npm install -g neovim

}

# Function to install AUR packages
install_aur_packages() {
  echo -e "${GREEN}Installing AUR packages with yay...${NC}"
  yay -S --needed "${AUR_PACKAGES[@]}"
}

# Function to install fonts
install_fonts() {
  echo -e "${GREEN}Installing fonts...${NC}"
  yay -S --needed "${FONT_PACKAGES[@]}"
}

# Function to install Arc icons
install_arc_icons() {
  echo -e "${GREEN}Installing Arc icons...${NC}"
  git clone https://github.com/horst3180/arc-icon-theme --depth 1 && cd arc-icon-theme
  ./autogen.sh --prefix=/usr
  sudo make install
  cd .. && rm -rf arc-icon-theme
}

# Function to install extra packages
install_core_packages() {
  echo -e "${GREEN}Installing extra packages...${NC}"
  sudo pacman -S --needed "${CORE_PACKAGES[@]}"
  yay -S --needed "${CORE_PACKAGES[@]}"
  sudo pacman -S --needed wget
  wget micro.mamba.pm/install.sh && chmod +x install.sh && ./install.sh && rm install.sh
}

# Main script logic
main() {
  while true; do
    display_main_menu
    selection=$(get_selection)

    case $selection in
    1)
      install_dependency_packages
      install_aur_packages
      ;;
    2)
      install_fonts
      ;;
    3)
      install_arc_icons
      ;;
    4)
      install_core_packages
      install_aur_packages
      ;;
    5)
      install_core_packages
      install_aur_packages
      install_fonts
      install_arc_icons
      install_core_packages
      ;;
    6)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo -e "${RED}Invalid selection. Please try again.${NC}"
      ;;
    esac
  done
}

# Run the main function
main
