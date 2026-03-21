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
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  # Core system packages
  environment.systemPackages = with pkgs; [
    curl
    git
    wget
    neovim
  ];

  # 1Password (for SSH signing)
  programs._1password.enable = true;
  programs._1password-gui.enable = true;

  # SSH
  services.openssh.enable = true;

  # System state version – do not change after first installation
  system.stateVersion = "24.11";
}
