{ pkgs, lib, ... }:

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
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/simenandre" else "/home/simenandre";
    # Do not change this after the first installation
    stateVersion = "24.11";
  };

  home.packages = with pkgs; [
    nodejs_22
  ];

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # Install Claude Code via npm on Linux (on macOS it's managed by Homebrew)
  home.activation.installClaudeCode = lib.mkIf (!pkgs.stdenv.isDarwin)
    (lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      export PATH="${pkgs.nodejs_22}/bin:$PATH"
      npm install -g @anthropic-ai/claude-code 2>/dev/null || true
    '');
}
