# dotfiles

My Development Setup, managed with [Nix](https://nixos.org), [nix-darwin](https://github.com/LnL7/nix-darwin), and [home-manager](https://github.com/nix-community/home-manager). Works on macOS and Linux.

## Quickstart

### 1. Install Nix

```shell
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### 2. Clone the repository

```shell
git clone git@github.com:simenandre/dotfiles.git ~/dotfiles
cd ~/dotfiles
git submodule update --init
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

#### Linux

Install [home-manager](https://github.com/nix-community/home-manager) as a standalone tool and apply the configuration:

```shell
# x86_64 (most common)
home-manager switch --flake .#simenandre

# aarch64 (ARM64, e.g. Raspberry Pi or ARM cloud instances)
home-manager switch --flake .#simenandre@aarch64-linux
```

## Structure

```
flake.nix               # Entry point – nix-darwin (macOS) + home-manager (macOS & Linux)
modules/
  darwin/
    default.nix         # System-level configuration (nix settings, core packages)
    homebrew.nix        # Homebrew packages (taps, brews, casks, Mac App Store)
    macos.nix           # macOS system defaults
  home/
    default.nix         # home-manager entry point (platform-aware home directory)
    git.nix             # Git configuration (platform-aware SSH signing path)
    zsh.nix             # Zsh configuration files
    starship.nix        # Starship prompt configuration
    tmux.nix            # Tmux configuration
    ghostty.nix         # Ghostty terminal configuration
```
