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
    nodejs_22
  ];

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # Install Claude Code via npm
  home.activation.installClaudeCode =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      export PATH="${pkgs.nodejs_22}/bin:$PATH"
      npm install -g @anthropic-ai/claude-code 2>/dev/null || true
    '';
}
