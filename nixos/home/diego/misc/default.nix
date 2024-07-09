{ pkgs, ...}:
{
  imports = [
    (import ./devel/devel.nix {inherit pkgs;})
  ];
}