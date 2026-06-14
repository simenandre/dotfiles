{ pkgs, lib, ... }:

{
  imports = [
    ./homebrew.nix
    ./macos.nix
  ];

  # Nix is managed by Determinate installer
  nix.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System state version – do not change after first installation
  system.stateVersion = 5;

  # Primary user for system defaults and homebrew
  system.primaryUser = "cobraz";

  # Enable Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # Remap Caps Lock to Escape
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  # Core system packages available to all users
  environment.systemPackages = with pkgs; [
    # GUI apps
    # Pin a newer release; the version in nixpkgs has a dead download URL.
    (whatsapp-for-mac.overrideAttrs (old: {
      version = "2.26.23.21";
      src = old.src.overrideAttrs (_: {
        outputHash = "sha256-1nVO9KaDC6aVnDc3T4CNVghVQcNuzPajMjD2GjNB0mA=";
      });
    }))

    # Editors and terminal multiplexers
    neovim
    tmux

    # Shells and shell utilities
    zsh
    bash
    ghq
    moreutils

    # GNU tools
    findutils
    gnused
    gnugrep

    # Networking tools
    curl
    nmap
    wget
    cloudflared

    # Compression libraries and tools
    lz4
    zlib
    zstd
    libffi
    p7zip
    pigz

    # Programming languages and runtimes
    golangci-lint
    zig
    typst
    rustup

    # JavaScript runtimes and package managers
    bun
    pnpm
    deno

    # Version control
    git
    git-lfs
    delta
    lazygit

    # Search tools
    ripgrep
    fzf

    # JSON/YAML processing tools
    jq
    yq-go

    # Protobuf and gRPC
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc

    # Cloud and IaC tools
    pulumi
    pulumictl
    kubectl
    kubernetes-helm
    cilium-cli
    doctl
    flyctl
    talosctl
    tektoncd-cli
    runpodctl

    # Task runners and automation
    act

    # Databases and database tools
    turso
    libpq
    sqlc

    # Terminal tools
    pv
    rename
    tree
    tldr
    starship
    gh
    htop

    # HTTP and web servers
    caddy
    goreleaser

    # Document and media tools
    pandoc
    ffmpeg
    tesseract
    ghostscript
    graphviz

    # Python tools
    pipx

    # Specific toolsets
    rclone
  ];
}
