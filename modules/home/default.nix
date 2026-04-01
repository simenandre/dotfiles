{ pkgs, lib, config, dina, ... }:

{
  imports = [
    ./claude.nix
    ./git.nix
    ./ghostty.nix
    ./starship.nix
    ./tmux.nix
    ./lazygit.nix
    ./twm.nix
    ./zsh.nix
  ];

  home = {
    homeDirectory = lib.mkForce (
      if pkgs.stdenv.isDarwin
      then "/Users/${config.home.username}"
      else "/home/${config.home.username}"
    );
    # Do not change this after the first installation
    stateVersion = "24.11";
  };

  home.packages = with pkgs; [
    claude-code
    dina.packages.${pkgs.stdenv.hostPlatform.system}.default
    delta
    fzf
    gh
    ghq
    git-get
    htop
    jq
    kubectl
    lazygit
    nodejs_22
    ripgrep
    starship
    talosctl
    tmux
    tree
    twm
    yq
    opencode
  ];

  programs.go.enable = true;

  # Let home-manager manage itself
  programs.home-manager.enable = true;
}
