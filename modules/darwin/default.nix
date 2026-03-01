{ pkgs, ... }:

{
  imports = [
    ./homebrew.nix
    ./macos.nix
  ];

  # Enable experimental Nix features
  nix.settings.experimental-features = "nix-command flakes";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System state version – do not change after first installation
  system.stateVersion = 5;

  # Enable Touch ID for sudo
  security.pam.enableSudoTouchIdAuth = true;

  # Core system packages available to all users
  environment.systemPackages = with pkgs; [
    curl
    git
    wget
  ];
}
