{ pkgs ? (import ../nixpkgs.nix) {}, inputs }:{

  arc = pkgs.callPackage ./icons/arc-icon-theme.nix {};
}