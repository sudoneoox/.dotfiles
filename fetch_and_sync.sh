#!/bin/bash

# Set colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Define the working directory
WD=$(pwd)

# Define the config directories to sync
CONFIGS=("fish" "kitty" "awesome" "awesome-desktop" "rofi" "picom" "nix" "nvim")

# Function to display the main menu
display_main_menu() {
    echo -e "${YELLOW}Select an action:${NC}"
    echo "1) Sync and push configs"
    echo "2) Revert to backup"
    echo "3) Exit"
}

# Function to display the sync menu
display_sync_menu() {
    echo -e "${YELLOW}Select which configs to sync and push:${NC}"
    echo "0) All"
    for i in "${!CONFIGS[@]}"; do
        echo "$((i+1))) ${CONFIGS[$i]}"
    done
    echo "$((${#CONFIGS[@]}+1))) Custom selection"
    echo "$((${#CONFIGS[@]}+2))) Back to main menu"
}

# Function to display the revert menu
display_revert_menu() {
    echo -e "${YELLOW}Select which config to revert:${NC}"
    for i in "${!CONFIGS[@]}"; do
        echo "$((i+1))) ${CONFIGS[$i]}"
    done
    echo "$((${#CONFIGS[@]}+1))) Back to main menu"
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
    cp -R "$HOME/.config/$config/"* "$WD/$config/.backup/" 2>/dev/null
    
    # Sync files
    rsync -av --delete "$HOME/.config/$config/" "$WD/$config/" --exclude .backup
    
    echo -e "${GREEN}$config synced and backed up.${NC}"
}

# Function to revert a specific config to its backup
revert_config() {
    local config=$1
    echo -e "${YELLOW}Reverting $config to backup...${NC}"
    
    if [ ! -d "$WD/$config/.backup" ]; then
        echo -e "${RED}No backup found for $config.${NC}"
        return
    fi
    
    # Remove everything except .backup
    find "$WD/$config" -mindepth 1 -maxdepth 1 ! -name .backup -exec rm -rf {} +
    
    # Move contents of .backup to the config directory
    mv "$WD/$config/.backup/"* "$WD/$config/"
    rmdir "$WD/$config/.backup"
    
    echo -e "${GREEN}$config reverted to backup.${NC}"
}

# Function to push changes to GitHub
push_to_github() {
    echo -e "${YELLOW}Pushing changes to GitHub...${NC}"
    git add .
    git commit -m "Update dotfiles: $(date '+%Y-%m-%d %H:%M:%S')"
    git push origin main
    echo -e "${GREEN}Changes pushed to GitHub.${NC}"
}

# Function to handle sync and push
handle_sync_and_push() {
    while true; do
        display_sync_menu
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
                return
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

# Function to handle revert
handle_revert() {
    while true; do
        display_revert_menu
        selection=$(get_selection)
        
        if [ "$selection" -eq $((${#CONFIGS[@]}+1)) ]; then
            return
        elif [ "$selection" -ge 1 ] && [ "$selection" -le "${#CONFIGS[@]}" ]; then
            revert_config "${CONFIGS[$((selection-1))]}"
            break
        else
            echo -e "${RED}Invalid selection. Please try again.${NC}"
        fi
    done
}

# Main script logic
main() {
    while true; do
        display_main_menu
        selection=$(get_selection)
        
        case $selection in
            1)
                handle_sync_and_push
                ;;
            2)
                handle_revert
                ;;
            3)
                echo "Exiting..."
                exit 0
                ;;
            *)
                echo -e "${RED}Invalid selection. Please try again.${NC}"
                ;;
        esac
    done
}

# Run the main function
main
