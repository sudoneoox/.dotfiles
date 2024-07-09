{ config, pkgs, lib, ... }:
{
  services.libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        middleEmulation = true;
        naturalScrolling = false;
    };
  };
  sound.enable = false;

  services.xserver.videoDrivers = [ "amdgpu" ];
  environment.systemPackages = with pkgs; [
    xorg.xf86inputevdev
    xorg.xf86inputlibinput
  ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}