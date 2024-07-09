{pkgs, ...}:
{

  home = {
    packages = with pkgs; [
      python3
      git
      gnumake
      cmake
      libgcc
    ];
  };
}
