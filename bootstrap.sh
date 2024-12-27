#!/bin/bash

# Install Homebrew if not installed
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install GNU Stow
brew install stow

# Install packages from Brewfile
cd apps && brew bundle

# Create symlinks using stow
cd ..
stow zsh
stow git
stow apps
stow config
stow tmux

# Install TPM for tmux
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Configure macOS defaults
sh macos/macos

# Setup Zsh
if [ ! -d "$HOME/.zsh-repos/znap" ]; then
  git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git ~/.zsh-repos/znap
fi

echo "Setup complete! Please restart your terminal."
