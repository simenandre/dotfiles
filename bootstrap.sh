#!/bin/bash

# Install Homebrew if not installed
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install packages from Brewfile
cd apps && brew bundle

# Install Cargos
cargo install \
  git-trim \
  starship \
  twm

# Create symlinks using stow
cd ..
stow_folders=(zsh git starship tmux nvim ghostty)
for folder in "${stow_folders[@]}"; do
  echo "stow $folder"
  stow -t $HOME -D $folder
  stow -t $HOME $folder
done

# Install TPM for tmux
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Configure macOS defaults with countdown
echo "Setting MacOS defaults in 10 seconds. Press CTRL+C to abort..."
sleep 10
echo ""

# Configure macOS defaults
sh macos/macos

# Setup Zsh
if [ ! -d "$HOME/.zsh-repos/znap" ]; then
  git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git ~/.zsh-repos/znap
fi

echo "Setup complete! Please restart your terminal."
