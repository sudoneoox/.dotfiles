function envs --description "Activate environment based on argument"
    switch $argv[1]
        case "conda"
            nix-shell /etc/nixos/home/diego/conf/env-shells/conda.nix
        case "java"
            nix-shell /etc/nixos/home/diego/conf/env-shells/java.nix
	case "mamba"
	    nix-shell /etc/nixos/home/diego/conf/env-shells/mamba.nix
        case '*'
            echo "Unknown environment: $argv[1]"
            echo "Available environments: conda, java"
    end
end
