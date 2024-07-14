#!/bin/bash

# Dynamically set the user's home directory
HOME_DIR="$(getent passwd "$USER" | cut -d: -f6)"

# Function to install dependencies with pacman and yay
install_deps() {
    echo "Installing dependencies with pacman..."
    sudo pacman -S --needed xorg xorg-xinit xterm git polkit polkit-gnome alsa-utils pulseaudio pulseaudio-alsa pavucontrol pipewire pipewire-pulse arandr at acpi

    echo "Installing AUR packages with yay..."
    yay -S --needed picom-git network-manager-applet volctl rofi lxappearance qt5ct kvantum pop-theme mugshot papirus-icon-theme awesome-git playerctl flameshot clipmenud blueman rofi clipmenu-rofi network-manager-applet
}

# Backup and set up AwesomeWM configuration
setup_awesome() {
    local awesome_config_dir="$HOME_DIR/.config/awesome"
    local backup_dir="$HOME_DIR/.config/awesome_backup_$(date +%Y%m%d-%H%M%S)"

    # Backup the existing config
    if [[ -d "$awesome_config_dir" ]]; then
        echo "Backing up existing AwesomeWM config..."
        mv "$awesome_config_dir" "$backup_dir"
    fi

    # Set up the new AwesomeWM config
    echo "Setting up new AwesomeWM config..."
    mkdir -p "$awesome_config_dir"
    cp -r ./awesomewm-fork/* "$awesome_config_dir"
}

# Move wallpapers
move_wallpapers() {
    local wallpaper_source="./wallpapers"
    local wallpaper_dest="$HOME_DIR/Pictures/wallpapers"

    echo "Moving wallpapers..."
    mkdir -p "$wallpaper_dest"
    cp -r "$wallpaper_source"/* "$wallpaper_dest"
}

# Move fonts
move_fonts() {
    local font_source="./fonts"
    local font_dest="$HOME_DIR/.local/share/fonts"

    echo "Moving fonts..."
    mkdir -p "$font_dest"
    cp -r "$font_source"/* "$font_dest"
}

arc_icons(){
    git clone https://github.com/horst3180/arc-icon-theme --depth 1 && cd arc-icon-theme
    ./autogen.sh --prefix=/usr
    sudo make install
}

setup_rofi(){
    local rofi_dest="$HOME_DIR/.config/rofi/"
    local rofi_source="$HOME_DIR/.config/awesome/rofi"
    echo "Moving rofi conf..."
    mkdir -p rofi_dest
    cp -rf rofi_source rofi_dest
}

double_monitor(){
    arandr
    echo 'ACTION=="change", RUN +="~/.config/awesome/arandr-auto/arandr_udev.sh' >> /etc/udev/rules.d/95-monitors.rules
    sudo udevadm control --reload-rules
}

# Main function to orchestrate the setup
main() {
    install_deps
    setup_awesome
    move_wallpapers
    move_fonts
    arc_icons
    setup_rofi
    echo "Installation and setup completed!"
}

main
