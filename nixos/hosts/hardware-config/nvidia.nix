{ config, lib, pkgs, ... }:
let 
  package = config.boot.kernelPackages.nvidiaPackages.production;
in
  { 
    hardware.graphics = {
      enable = true; 
    };
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      modesetting.enable = true; 
      powerManagement.enable = false; 
      powerManagement.finegrained = false; 
      open = false; 
      nvidiaSettings = true; 
      package = pkgs.nvidia-patch.patch-nvenc (pkgs.nvidia-patch.patch-fbc package);
      prime.nvidiaBusId = "PCI:0:2b:00.0";
    };

    sound.enable = true;
    hardware.pulseaudio.enable = true;


    services.xserver.displayManager.sessionCommands = ''
     xrandr --output HDMI-0 --mode 1920x1080 --output DVI-D-0 --mode 1920x1080 --right-of HDMI-0
    '';
  }
