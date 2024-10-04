#!/bin/bash

# Set colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Define the working directory
WD=$(pwd)

# Define the config directories to sync
CONFIGS=("fish" "kitty" "awesome" "awesome-desktop" "rofi" "picom" "nixos")

# Function to display the menu
display_menu() {
    echo -e "${YELLOW}Select which configs to sync and push:${NC}"
    echo "0) All"
    for i in "${!CONFIGS[@]}"; do
        echo "$((i+1))) ${CONFIGS[$i]}"
    done
    echo "$((${#CONFIGS[@]}+1))) Custom selection"
    echo "$((${#CONFIGS[@]}+2))) Exit"
}

# Function to get user selection
get_selection() {
    local selection
    read -p "Enter your choice: " selection
    echo $selection
}

# Function to sync and backup a specific config
sync_config() {
    local config=$1
    echo -e "${GREEN}Syncing $config...${NC}"
    
    # Remove old backup if exists
    rm -rf "$WD/$config/.backup"
    
    # Create new backup
    mkdir -p "$WD/$config/.backup"
    cp -R "$HOME/.config/$config"/* "$WD/$config/.backup/" 2>/dev/null
    
    # Sync files
    rsync -av --delete "$HOME/.config/$config/" "$WD/$config/" --exclude .backup
    
    echo -e "${GREEN}$config synced and backed up.${NC}"
}

# Function to push changes to GitHub
push_to_github() {
    echo -e "${YELLOW}Pushing changes to GitHub...${NC}"
    git add .
    git commit -m "Update dotfiles: $(date '+%Y-%m-%d %H:%M:%S')"
    git push origin main
    echo -e "${GREEN}Changes pushed to GitHub.${NC}"
}

# Main script logic
main() {
    while true; do
        display_menu
        selection=$(get_selection)
        
        case $selection in
            0)
                for config in "${CONFIGS[@]}"; do
                    sync_config "$config"
                done
                push_to_github
                break
                ;;
            $((${#CONFIGS[@]}+1)))
                echo "Enter the configs you want to sync (space-separated):"
                read -a custom_configs
                for config in "${custom_configs[@]}"; do
                    if [[ " ${CONFIGS[@]} " =~ " ${config} " ]]; then
                        sync_config "$config"
                    else
                        echo -e "${RED}Invalid config: $config${NC}"
                    fi
                done
                push_to_github
                break
                ;;
            $((${#CONFIGS[@]}+2)))
                echo "Exiting..."
                exit 0
                ;;
            *)
                if [ "$selection" -ge 1 ] && [ "$selection" -le "${#CONFIGS[@]}" ]; then
                    sync_config "${CONFIGS[$((selection-1))]}"
                    push_to_github
                    break
                else
                    echo -e "${RED}Invalid selection. Please try again.${NC}"
                fi
                ;;
        esac
    done
}

# Run the main function
main
