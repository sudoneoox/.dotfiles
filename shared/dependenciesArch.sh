install_deps(){
  echo "installing dependencies"
  sudo pacman -S --needed xorg xorg-xinit xterm git polkit polkit-gnome alsa-utils pulseaudio pulseaudio-alsa pavucontrol pipewire pipewire-pulse arandr at acpi git brightnessctl

  echo "Installing AUR packages with paru..."
  paru -S --needed picom-git network-manager-applet volctl rofi lxappearance qt5ct kvantum pop-theme mugshot papirus-icon-theme awesome-git playerctl flameshot clipmenu-rofi blueman rofi clipmenu-rofi network-manager-applet maim i3lock-color nitrogen

  echo "downloading fonts"
  paru -S --needed ttf-iosevka-nerd ttf-mononoki-nerd ttf-roboto ttf-fira-mono 


  echo "downloading arc icons"
  git clone https://github.com/horst3180/arc-icon-theme --depth 1 && cd arc-icon-theme
  ./autogen.sh --prefix=/usr
  sudo make install  


}
