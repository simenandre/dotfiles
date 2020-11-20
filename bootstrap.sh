#!/bin/bash

source brew.sh
source ./.vscode/vscode.sh

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install Volta (https://volta.sh/)
curl https://get.volta.sh | bash
