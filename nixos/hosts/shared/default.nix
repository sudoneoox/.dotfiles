{ pkgs, outputs, overlays, lib, inputs, ... }:
{


  imports = [
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  networking.networkmanager.enable = true;  

  security.sudo.enable = true;
  services.blueman.enable = true;
  time = {
    hardwareClockInLocalTime = true;
    timeZone = "US/Central";
  };

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  programs.fish.enable = true;
  users = {
    users.diego = {
      isNormalUser = true;
      password = "abc";
      extraGroups = [ "wheel" "storage" "power" "audio" "video" "libvirtd" "networkmanager"]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [ ];
    };
    defaultUserShell = pkgs.fish;
  };

  ### VIRT
  programs.virt-manager.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };







  hardware.bluetooth = {
    enable = true;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
    powerOnBoot = true;
  };

  services.dbus.enable = true;
  services.openssh.enable = true;
  services.printing.enable = true;


  environment.systemPackages = with pkgs; [
    virtmanager
    wget
    vscode
    fish
    nano
    kitty
    pciutils
    killall
    firefox
    home-manager
    bluez
    direnv
    xdg-utils
    pavucontrol
    mpv
    xorg.xf86inputevdev
    xorg.xf86inputsynaptics
    xorg.xf86inputlibinput
    xorg.xorgserver
    xorg.xf86videoati
  ];

  environment.shells = with pkgs; [fish];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = true;
      warn-dirty = false;
      substituters = [ "https://nix-gaming.cachix.org" ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 5d";
    };
    optimise.automatic = true;
  };

  system = {
    copySystemConfiguration = false;
    stateVersion = "24.05";
  };

}