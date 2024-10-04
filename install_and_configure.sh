#!/bin/bash

install_deps(){
  echo "installing dependencies"
  sudo pacman -S --needed xorg xorg-xinit xterm git polkit polkit-gnome alsa-utils pulseaudio pulseaudio-alsa pavucontrol pipewire pipewire-pulse arandr at acpi git brightnessctl 

  echo "Installing AUR packages with paru..."
  paru -S --needed picom-git network-manager-applet volctl rofi lxappearance qt5ct kvantum pop-theme mugshot papirus-icon-theme awesome-git playerctl flameshot clipmenu-rofi blueman rofi clipmenu-rofi  maim i3lock-color nitrogen playerctl

  echo "downloading fonts"
  paru -S --needed ttf-iosevka-nerd ttf-mononoki-nerd ttf-roboto ttf-fira-mono 


  echo "downloading arc icons"
  git clone https://github.com/horst3180/arc-icon-theme --depth 1 && cd arc-icon-theme
  ./autogen.sh --prefix=/usr
  sudo make install  
}

other_installs_not_deps(){
  sudo pacman -S webkit2gtk-4.1 networkmanager-openconnect localsend-bin cups
  paru -S --needed btop bat filelight syncthing
}

if [ "$#" -eq 0 ]; then  
    install_deps
elif [ "$1" == "extra" ]; then
    echo "installing extras"
    other_installs_not_deps
fi
