#!/bin/bash

# Colors
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
BLUE="\033[1;34m"
RESET="\033[0m"

REPO_URL="https://github.com/yam0822/yam.git"
INSTALL_PATH="/usr/local/bin/yam"

echo -e "${BLUE}=== YAM Installer ===${RESET}"

# Check if yam is already installed
if command -v yam >/dev/null 2>&1; then
    echo -e "${YELLOW}[!] yam is already installed. Updating...${RESET}"

    # Find where yam was originally cloned
    if [ -d "./yam" ]; then
        echo -e "${GREEN}[+] Using existing local repo...${RESET}"
        cd yam || exit
        git pull
    else
        echo -e "${GREEN}[+] Cloning fresh repo...${RESET}"
        git clone "$REPO_URL"
        cd yam || exit
    fi

    sudo mv yam "$INSTALL_PATH"
    sudo chmod +x "$INSTALL_PATH"

    echo -e "${GREEN}[✓] yam has been updated successfully!${RESET}"
    exit 0
else
    echo -e "${YELLOW}[!] yam is not installed. Installing now...${RESET}"

    # Clone repo
    git clone "$REPO_URL" || {
        echo -e "${RED}[x] Failed to clone repo.${RESET}"
        exit 1
    }

    cd yam || exit

    # Install file
    sudo mv yam "$INSTALL_PATH"
    sudo chmod +x "$INSTALL_PATH"

    echo -e "${GREEN}[✓] yam has been installed successfully!${RESET}"
    exit 0
fi
