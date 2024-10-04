#!/bin/bash

# Set colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Define the working directory and config directory
WD=$(pwd)
CONFIG_DIR="$HOME/.config"

# Define the config directories to manage
CONFIGS=("awesome" "rofi" "picom" "kitty" "fish" "nvim")

# Function to display the main menu
display_main_menu() {
    echo -e "${YELLOW}Select an action:${NC}"
    echo "1) Push configurations"
    echo "2) Revert configurations"
    echo "3) Exit"
}

# Function to display the push menu
display_push_menu() {
    echo -e "${YELLOW}Select which configs to push:${NC}"
    echo "0) All"
    for i in "${!CONFIGS[@]}"; do
        echo "$((i+1))) ${CONFIGS[$i]}"
    done
    echo "$((${#CONFIGS[@]}+1))) Back to main menu"
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

# Function to push a specific config
push_config() {
    local config=$1
    echo -e "${GREEN}Pushing $config...${NC}"
    
    # Create backup
    if [ -d "$CONFIG_DIR/$config" ]; then
        backup_dir="$CONFIG_DIR/$config.backup.$(date +%Y%m%d%H%M%S)"
        cp -R "$CONFIG_DIR/$config" "$backup_dir"
        echo -e "${GREEN}Backup created: $backup_dir${NC}"
    fi
    
    # Push configuration
    if [ -d "$WD/$config" ]; then
        rsync -av --delete "$WD/$config/" "$CONFIG_DIR/$config/"
        echo -e "${GREEN}$config pushed successfully.${NC}"
    else
        echo -e "${RED}$config directory not found in working directory.${NC}"
    fi
}

# Function to revert a specific config
revert_config() {
    local config=$1
    echo -e "${YELLOW}Reverting $config...${NC}"
    
    # Find the most recent backup
    local backup_dir=$(ls -td "$CONFIG_DIR/$config.backup."* | head -n1)
    
    if [ -z "$backup_dir" ]; then
        echo -e "${RED}No backup found for $config.${NC}"
        return
    fi
    
    # Revert to backup
    rm -rf "$CONFIG_DIR/$config"
    cp -R "$backup_dir" "$CONFIG_DIR/$config"
    echo -e "${GREEN}$config reverted to backup: $backup_dir${NC}"
}

# Function to handle pushing configs
handle_push() {
    while true; do
        display_push_menu
        selection=$(get_selection)
        
        case $selection in
            0)
                for config in "${CONFIGS[@]}"; do
                    push_config "$config"
                    echo "$config"
                done
                break
                ;;
            $((${#CONFIGS[@]}+1)))
                return
                ;;
            *)
                if [ "$selection" -ge 1 ] && [ "$selection" -le "${#CONFIGS[@]}" ]; then
                    push_config "${CONFIGS[$((selection-1))]}"
                else
                    echo -e "${RED}Invalid selection. Please try again.${NC}"
                fi
                ;;
        esac
    done
}

# Function to handle reverting configs
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
                handle_push
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
