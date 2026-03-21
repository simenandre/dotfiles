{ pkgs, lib, config, ... }:

{
  imports = [
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
  ];

  # Let home-manager manage itself
  programs.home-manager.enable = true;
}
