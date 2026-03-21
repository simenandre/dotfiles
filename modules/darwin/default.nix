{ pkgs, ... }:

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
    curl
    git
    wget
  ];
}
