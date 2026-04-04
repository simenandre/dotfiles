{ pkgs, lib, ... }:

{
  imports = [ ];

  # Enable experimental Nix features
  nix.settings.experimental-features = "nix-command flakes";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixbox";
  networking.networkmanager.enable = true;

  # Timezone / locale
  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_US.UTF-8";

  # User account
  users.users.simenandre = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDDXfT23Ne7Rl/rdiqrLf4vWfQqgUCo26+NcL41PVSag"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJwHftCdnV/pscQ4qCK/biIBsKk/G0A3hLVI1o62CJF4 so@bjerk.io"
    ];
  };
  programs.zsh.enable = true;


  # Core system packages
  environment.systemPackages = with pkgs; [
    curl
    gcc
    git
    wget
    neovim
    ghostty.terminfo
  ];

  # 1Password (for SSH signing)
  programs._1password.enable = true;
  programs._1password-gui.enable = true;

  # Docker
  virtualisation.docker.enable = true;

  # SSH
  services.openssh.enable = true;

  # System state version – do not change after first installation
  system.stateVersion = "24.11";
}
