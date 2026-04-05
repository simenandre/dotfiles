{ ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    taps = [
      "oven-sh/bun"
      "pulumi/tap"
      "tursodatabase/tap"
      "simenandre/tools"
      "anomalyco/tap"
      "siderolabs/tap"
    ];

    brews = [
      # Editors and terminal multiplexers
      "neovim"
      "tmux"

      # Shells and shell utilities
      "zsh"
      "bash"
      "bash-completion"
      "ghq"
      "moreutils"

      # GNU tools
      "findutils"
      "gnu-sed"
      "grep"

      # Networking tools
      "openssh"
      "nmap"
      "wget"
      "cloudflared"

      # Compression libraries and tools
      "lz4"
      "zlib"
      "zstd"
      "libffi"
      "p7zip"
      "pigz"

      # Programming languages and runtimes
      "golangci-lint"
      "zig"
      "typst"

      # JavaScript runtimes and package managers
      "bun"
      "pnpm"
      "deno"

      # Version control
      "git"
      "git-lfs"
      "git-delta"
      "lazygit"

      # Search tools
      "ripgrep"
      "fzf"

      # JSON/YAML processing tools
      "jq"
      "yq"

      # Protobuf and gRPC
      "protobuf"
      "protoc-gen-go"
      "protoc-gen-go-grpc"

      # Cloud and IaC tools
      "pulumi"
      "pulumictl"
      "kubectl"
      "helm"
      "cilium-cli"
      "doctl"
      "flyctl"
      "talosctl"
      "tektoncd-cli"
      "runpodctl"
      # Container tools
      "docker"
      "docker-buildx"
      "docker-compose"
      "docker-completion"
      "colima"
      "podman"
      "podman-compose"

      # Task runners and automation
      "act"

      # Databases and database tools
      "turso"
      "libpq"
      "sqlc"

      # Terminal tools
      "pv"
      "rename"
      "tree"
      "tldr"
      "starship"
      "gh"
      "htop"

      # HTTP and web servers
      "caddy"
      "goreleaser"

      # Document and media tools
      "pandoc"
      "ffmpeg"
      "tesseract"
      "ghostscript"
      "graphviz"

      # Python tools
      "pipx"

      # Specific toolsets
      "rclone"

      # Mac App Store CLI
      "mas"
    ];

    casks = [
      "1password"
      "1password-cli"
      "arc"
      "basictex"
      "claude"
      "discord"
      "elgato-camera-hub"
      "figma"
      "font-jetbrains-mono"
      "font-symbols-only-nerd-font"
      "gcloud-cli"
      "ghostty"
      "google-chrome"
      "google-drive"
      "loom"
      "microsoft-teams"
      "obsidian"
      "postico"
      "proton-mail"
      "protonvpn"
      "raycast"
      "signal"
      "slack"
      "sonos"
      "spotify"
      "visual-studio-code"
      "zoom"
    ];

    masApps = {
      "Tailscale" = 1475387142;
      "Jojo" = 1659864300;
    };
  };
}
