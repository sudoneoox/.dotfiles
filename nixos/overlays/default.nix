{ inputs, ... }:
{
  additions = final: _prev: import ../pkgs { pkgs = final; inherit inputs; };
  modifications = final: prev: {
    myAwesome = (prev.awesome.override {gtk3Support = true;}).overrideAttrs (old: rec {
      pname = "myAwesome";
      version = "4.3.xxxxx";
      src = prev.fetchFromGitHub {
        owner = "awesomeWM";
        repo = "awesome";
        rev = "ad0290bc1aac3ec2391aa14784146a53ebf9d1f0";
        hash = "sha256-uaskBbnX8NgxrprI4UbPfb5cRqdRsJZv0YXXshfsxFU=";
      };
      patches = [];
      
      postPatch = ''
        patchShebangs tests/examples/_postprocess.lua 
        patchShebangs tests/examples/_postprocess_cleanup.lua    
      '';

      cmakeFlags = old.cmakeFlags ++ ["-DGENERATE_MANPAGES=OFF"];
      extraGIPackages = with prev.pkgs; [networkmanager upower playerctl ];
      GI_TYPELIB_PATH =
        let
          mkTypeLibPath = pkg: "${pkg}/lib/girepository-1.0";
          extraGITypeLibPaths = prev.lib.forEach extraGIPackages mkTypeLibPath;
        in
        prev.lib.concatStringsSep ":" (extraGITypeLibPaths ++ [ (mkTypeLibPath prev.pango.out) ]);
    });

    conf-pkg-config = prev.conf-pkg-config.overrideAttrs (oldAttrs: {
      propagatedBuildInputs = [ prev.pkg-config ];
      propagatedNativeBuildInputs = [ prev.pkg-config ];
    });
  };
}