let
  pkgs = import <nixpkgs> { overlays = [ (self: super: {
    jdk = super.adoptopenjdk-jre-bin;
  }) ]; };
in
with pkgs;
stdenv.mkDerivation {
  name = "clojure";
  nativeBuildInputs = [
    jdk
    leiningen
    clojure
  ];
  buildInputs = [
    openssl
  ];

  shellHook = ''
    export SHELL=$(which fish)
    exec fish
  '';
  
}
