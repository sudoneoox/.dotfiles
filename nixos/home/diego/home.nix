{inputs, config, pkgs, lib, ... }:

{
  home.username = "diego";
  home.homeDirectory = "/home/diego";
  home.stateVersion = "24.05";
  
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "sudoneoox";
    userEmail = "diegoa2992@gmail.com";
  };

  nixpkgs.overlays = [
    inputs.nur.overlay
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowInsecure = true;
    allowUnfreePredicate = _: true;
  };

  nixpkgs.config.permittedInsecurePackages = [];

  home = {
    activation = {}; # on activation script
    packages = with pkgs; [
      iosevka
      nerdfonts
      arc-icon-theme
      git
      vscode
      i3lock-color
      pavucontrol
      moreutils
      socat
      kitty
      fish
      networkmanager-openconnect
    ];
  };

  imports = [
    #app configurations
    (import ./conf/shell/fish/default.nix {inherit pkgs;})      
    (import ./misc/default.nix {inherit pkgs;})
  ];  

}
