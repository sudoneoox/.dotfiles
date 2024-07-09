
{ inputs, outputs, config, pkgs, lib, self, ... }:



{
  imports =
    [ # Include the results of the hardware scan.
      ../hardware-config/hardware-configuration-desktop.nix
      # ../hardware-config/hardware-configuration-laptop.nix
      # ../hardware-config/amd-laptop.nix
      ../hardware-config/nvidia.nix
      ../shared
    ];

  nixpkgs = {
    overlays = [
      # inputs.nixpkgs-f2k.overlays.stdenvs
      # inputs.nixpkgs-f2k.overlays.compositors
      # (final: prev:
      # {
      #   awesome-git = inputs.nixpkgs-f2k.packages.${pkgs.system}.awesome-git;
      # })


      inputs.nur.overlay
      inputs.nvidia-patch.overlays.default
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
    config = {
      allowUnfreePredicate = true;
      allowUnfree = true;
    };
  };
  environment.systemPackages = with pkgs; [  
    pkgs.myAwesome
    git
    lua
    luajitPackages.luarocks
    luajitPackages.lgi
    gobject-introspection
    gtk3
    xorg.xwininfo
    nitrogen
    caffeine-ng
    networkmanagerapplet
    rofi
    clipmenu
    picom
    flameshot
    dex
    brightnessctl
  ];
  networking.hostName = "nixos";  
  services = {
    power-profiles-daemon.enable = false;
    upower.enable = true;
    xserver = {
      enable = true;
      windowManager.awesome.enable = true;
      windowManager.awesome.package = pkgs.myAwesome;
      displayManager.sessionCommands = ''
      awesome -c /home/diego/.config/awesome/rc.lua
      '';
      displayManager.startx.enable = true;
    };
    displayManager = {
      defaultSession = "none+awesome";
      sddm.enable = true;
    };
  };

}

