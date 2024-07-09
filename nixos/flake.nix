{
  description = "multicolor awesome nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs-f2k.url = "github:moni-dz/nixpkgs-f2k";
    nur.url = "github:nix-community/NUR";
    nvidia-patch.url = "github:icewind1991/nvidia-patch-nixos";  
    nvidia-patch.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... } @inputs:
  let
      inherit (self) outputs;
      forSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;

      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      overlays = import ./overlays { inherit inputs; };
      # host configurations
      nixosConfigurations = {
        multicolor = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            inputs.home-manager.nixosModule
            ./hosts/multicolor/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        diego = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs outputs self; };
          modules = [
            ./home/diego/home.nix
          ];
        };
      };

      multicolor = self.nixosConfigurations.frostbyte.config.system.build.toplevel;

      packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

      packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
    };
}
