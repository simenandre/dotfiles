{ pkgs, ... }:

{
  imports = [
    ./git.nix
    ./ghostty.nix
    ./starship.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home = {
    username = "simenandre";
    homeDirectory = "/Users/simenandre";
    # Do not change this after the first installation
    stateVersion = "24.11";
  };

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # Link neovim config (managed as a git submodule)
  home.file.".config/nvim".source = ../../nvim/.config/nvim;
}
