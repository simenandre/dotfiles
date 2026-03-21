# dotfiles

My Development Setup, managed with [Nix](https://nixos.org), [nix-darwin](https://github.com/LnL7/nix-darwin), and [home-manager](https://github.com/nix-community/home-manager). Works on macOS, NixOS, and standalone Linux.

## Quickstart

### 1. Install Nix

```shell
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### 2. Clone the repository

```shell
git clone git@github.com:simenandre/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 3. Apply the configuration

#### macOS

On first run, bootstrap nix-darwin:

```shell
nix run nix-darwin -- switch --flake .#default
```

On subsequent runs:

```shell
darwin-rebuild switch --flake .#default
```

#### NixOS

Generate hardware config and rebuild:

```shell
sudo nixos-generate-config --show-hardware-config > modules/nixos/hardware-configuration.nix
sudo nixos-rebuild switch --flake .#nixbox
```

#### Linux (standalone home-manager)

```shell
# x86_64
home-manager switch --flake .#simenandre

# aarch64
home-manager switch --flake .#simenandre@aarch64-linux
```

## Structure

```
flake.nix               # Entry point – inputs & all configurations
modules/
  darwin/
    default.nix         # System-level configuration (nix settings, core packages)
    homebrew.nix         # Homebrew packages (taps, brews, casks, Mac App Store)
    macos.nix            # macOS system defaults
  home/
    default.nix          # home-manager entry point (platform-aware home directory)
    git.nix              # Git configuration (platform-aware SSH signing path)
    zsh.nix              # Zsh configuration (zshenv, zshrc, aliases, path, extras)
    starship.nix         # Starship prompt
    tmux.nix             # Tmux configuration
    ghostty.nix          # Ghostty terminal configuration
  nixos/
    default.nix          # NixOS system configuration
scripts/
  cleanup.sh             # macOS cleanup utility
```
