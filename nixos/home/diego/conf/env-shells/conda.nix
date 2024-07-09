{ pkgs ? import <nixpkgs> {} }:

let
  installationPath = "~/.conda";

 minicondaScript = pkgs.stdenv.mkDerivation rec {
    name = "miniconda-${version}";
    version = "4.3.11";
    src = pkgs.fetchurl {
      url = "https://repo.continuum.io/miniconda/Miniconda3-${version}-Linux-x86_64.sh";
      sha256 = "1f2g8x1nh8xwcdh09xcra8vd15xqb5crjmpvmc2xza3ggg771zmr";
    };
    unpackPhase = "true";
    installPhase = ''
      mkdir -p $out
      cp $src $out/miniconda.sh
    '';
    fixupPhase = ''
      chmod +x $out/miniconda.sh
    '';
  };

  conda = pkgs.runCommand "conda-install"
    { buildInputs = [ pkgs.makeWrapper minicondaScript ]; }
    ''
      mkdir -p $out/bin
      makeWrapper                            \
        ${minicondaScript}/miniconda.sh      \
        $out/bin/conda-install               \
        --add-flags "-p ${installationPath}" \
        --add-flags "-b"                     \
        --add-flags "-u"
    '';

in
(
  pkgs.buildFHSUserEnv {
    name = "conda";
    targetPkgs = pkgs: (
      with pkgs; [
        conda
        xorg.libSM
        xorg.libICE
        xorg.libXrender
        libselinux
        python3
        gcc
        emacs
        git
      ]
    );
    profile = ''
      export PATH=${installationPath}/bin:$PATH
      export NIX_CFLAGS_COMPILE="-I${installationPath}/include"
      export NIX_CFLAGS_LINK="-L${installationPath}/lib"
      export FONTCONFIG_FILE=/etc/fonts/fonts.conf
      export QTCOMPOSE=${pkgs.xorg.libX11}/share/X11/locale
      # Initialize Conda
      conda-install
      source ${installationPath}/bin/activate
    '';
    shellHook = ''
      if test -n "$FISH_VERSION"
        echo "Already in Fish shell"
      else
        exec fish
      end
    '';
  }
).env
