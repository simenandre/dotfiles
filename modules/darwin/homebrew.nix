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
      "simenandre/tools"
      "anomalyco/tap"
    ];

    # Note: most CLI tools live in nixpkgs (modules/darwin/default.nix).
    # These stay in brew on purpose: shell completions, the macOS container
    # stack, system ssh, and the Mac App Store CLI.
    brews = [
      # Shell completions
      "bash-completion"

      # System ssh
      "openssh"

      # Container tools (kept in brew for reliable macOS runtime)
      "docker"
      "docker-buildx"
      "docker-compose"
      "docker-completion"
      "colima"
      "podman"
      "podman-compose"

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
      "Adobe Lightroom" = 1451544217;
    };
  };
}
