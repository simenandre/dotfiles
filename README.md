# dotfiles

My Development Setup, managed with [Nix](https://nixos.org), [nix-darwin](https://github.com/LnL7/nix-darwin), and [home-manager](https://github.com/nix-community/home-manager). Works on macOS, NixOS, and standalone Linux.

## Quickstart

Setting up a new machine? Follow [INSTALL.md](INSTALL.md) — it covers the
prerequisites (Homebrew, App Store, 1Password SSH agent) that the commands below
assume are already in place.

### 1. Install Determinate Nix

```shell
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --determinate
```

### 2. Clone the repository

```shell
git clone https://github.com/simenandre/dotfiles.git ~/ghq/github.com/simenandre/dotfiles
cd ~/ghq/github.com/simenandre/dotfiles
```

### 3. Apply the configuration

#### macOS

On first run, bootstrap nix-darwin:

```shell
sudo nix run nix-darwin#darwin-rebuild -- switch --flake .#default
```

On subsequent runs:

```shell
sudo darwin-rebuild switch --flake .#default
```

#### NixOS

Generate hardware config and rebuild:

```shell
sudo nixos-generate-config --show-hardware-config > hosts/nixbox/hardware-configuration.nix
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
INSTALL.md              # Full setup guide for a new machine
hosts/
  nixbox/
    hardware-configuration.nix
modules/
  darwin/
    default.nix          # System-level configuration (nix settings, core packages)
    homebrew.nix         # Homebrew packages (taps, brews, casks, Mac App Store)
    macos.nix            # macOS system defaults
  home/
    default.nix          # home-manager entry point (platform-aware home directory)
    claude.nix           # Claude Code instructions and skills
    git.nix              # Git configuration (platform-aware SSH signing path)
    zsh.nix              # Zsh configuration (zshenv, zshrc, aliases, path, completions)
    starship.nix         # Starship prompt
    tmux.nix             # Tmux configuration
    lazygit.nix          # Lazygit configuration
    twm.nix              # twm workspace manager configuration
    ghostty.nix          # Ghostty terminal configuration
  nixos/
    default.nix          # NixOS system configuration
scripts/
  cleanup.sh             # macOS cleanup utility
```
