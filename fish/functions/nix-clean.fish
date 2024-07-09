function nix-clean --description "garbage collect"
    sudo nix-collect-garbage -d
    sudo nix-store --gc
    sudo nix-store --optimize
end
