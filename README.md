# dotfiles

My Development Setup, managed with [Nix](https://nixos.org), [nix-darwin](https://github.com/LnL7/nix-darwin), and [home-manager](https://github.com/nix-community/home-manager).

## Quickstart

### 1. Install Nix

```shell
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### 2. Clone the repository

```shell
git clone git@github.com:simenandre/dotfiles.git ~/dotfiles
cd ~/dotfiles
git submodule update --init --recursive
```

### 3. Apply the configuration

On first run, bootstrap nix-darwin:

```shell
nix run nix-darwin -- switch --flake .#default
```

On subsequent runs:

```shell
darwin-rebuild switch --flake .#default
```

## Structure

```
flake.nix               # Entry point – nix-darwin + home-manager
modules/
  darwin/
    default.nix         # System-level configuration (nix settings, core packages)
    homebrew.nix        # Homebrew packages (taps, brews, casks, Mac App Store)
    macos.nix           # macOS system defaults (replaces macos/macos script)
  home/
    default.nix         # home-manager entry point
    git.nix             # Git configuration (programs.git)
    zsh.nix             # Zsh configuration files
    starship.nix        # Starship prompt configuration
    tmux.nix            # Tmux configuration
    ghostty.nix         # Ghostty terminal configuration
apps/
  Brewfile              # Legacy Brewfile (superseded by modules/darwin/homebrew.nix)
macos/
  macos                 # Legacy macOS defaults script (superseded by modules/darwin/macos.nix)
```
