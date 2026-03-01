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
      "bramstein/webfonttools"
      "danielgtaylor/restish"
      "oven-sh/bun"
      "pulumi/tap"
      "go-task/tap"
      "tursodatabase/tap"
      "yakitrak/yakitrak"
      "simenandre/tools"
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

      # Security and encryption
      "gnupg"
      "git-secret"
      "ssh-copy-id"

      # Compression libraries and tools
      "lz4"
      "zlib"
      "zstd"
      "libffi"
      "p7zip"
      "pigz"
      "zopfli"

      # Programming languages and runtimes
      "golang"
      "golangci-lint"
      "python@3.11"
      "rust"
      "zig"
      "pkl"

      # Font tools
      "sfnt2woff"
      "sfnt2woff-zopfli"
      "woff2"

      # JavaScript runtimes and package managers
      "bun"
      "pnpm"
      "volta"
      "corepack"
      "deno"

      # REST API clients
      "danielgtaylor/restish/restish"

      # Version control
      "git"
      "git-lfs"
      "lazygit"
      "microplane"

      # Search tools
      "ripgrep"
      "ack"
      "fzf"

      # JSON/YAML processing tools
      "jq"
      "yq"

      # Cloud and IaC tools
      "pulumi"
      "crd2pulumi"
      "kube2pulumi"
      "pulumictl"
      "tf2pulumi"
      "azure-cli"
      "kubectl"
      "helm"
      "cilium-cli"
      "doctl"
      "flyctl"

      # Container tools
      "podman"
      "podman-compose"

      # Task runners and automation
      "go-task"
      "act"

      # Databases and database tools
      "turso"
      "libpq"
      "sqld"

      # Terminal tools
      "pv"
      "rename"
      "rlwrap"
      "tree"
      "screen"
      "vbindiff"
      "tmate"
      "asciinema"
      "dasel"
      "tldr"
      "starship"
      "gh"

      # HTTP and web servers
      "caddy"
      "goreleaser"

      # Specific toolsets
      "whalebrew"
      "gd"
      "ghostscript"
      "rclone"
      "graphviz"

      # Mac App Store CLI
      "mas"
    ];

    casks = [
      "spotify"
      "slack"
      "sonos"
      "figma"
      "discord"
      "grammarly"
      "microsoft-remote-desktop"
      "postico"
      "cyberduck"
      "adobe-creative-cloud"
      "1password-cli"
      "protonvpn"
      "openvpn-connect"
      "raycast"
      "rectangle"
      "google-chrome"
      "google-drive"
      "karabiner-elements"
      "postman"
      "ghostty"
      "proton-mail"
      "claude"
      "font-symbols-only-nerd-font"
      "font-jetbrains-mono"
      "google-cloud-sdk"
      "docker"
      "podman-desktop"
      "microsoft-teams"
      "zoom"
      "obsidian"
    ];

    masApps = {
      "Outline" = 1356178125;
      "Remote Desktop" = 409907375;
    };
  };
}
