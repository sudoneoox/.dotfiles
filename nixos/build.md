
# build nixosConfig
```bash
nix build .#nixosConfigurations.multicolor.config.system.build.toplevel
```
# build homemanager config
```bash
nix build .#homeConfigurations.diego.activationPackage
```
# apply nixos config
```bash
sudo nixos-rebuild switch --flake .#multicolor
```
# apply homemanager config
```bash
home-manager switch --flake .#diego
```
# garbage collect
```bash
sudo nix-collect-garbage -d
sudo nix-store --gc
sudo nix-store --optimize
```