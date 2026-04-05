{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    signing = if pkgs.stdenv.isDarwin then {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMCyUn5BfmAnd/6xi0X1mYF/+jPOmCS0bpNUePF55gCY";
      signByDefault = true;
    } else {
      signByDefault = false;
    };

    settings = {
      user = {
        name = "Simen A. W. Olsen";
        email = "hello@simenandre.no";
      };
      apply.whitespace = "fix";
      core = {
        trustctime = false;
        editor = "nvim";
        excludesfile = "~/.gitignore_global";
      };
      color.ui = "auto";
      "color \"branch\"" = {
        current = "yellow reverse";
        local = "yellow";
        remote = "green";
      };
      "color \"diff\"" = {
        meta = "yellow bold";
        frag = "magenta bold";
        old = "red";
        new = "green";
      };
      "color \"status\"" = {
        added = "yellow";
        changed = "green";
        untracked = "cyan";
      };
      diff.renames = "copies";
      help.autocorrect = 1;
      merge.log = true;
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      github.user = "simenandre";
      pull.rebase = true;
    } // (if pkgs.stdenv.isDarwin then {
      gpg.format = "ssh";
      "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      "url \"ssh://git@github.com/\"".insteadOf = "https://github.com/";
      commit.gpgsign = true;
    } else {});
  };
}
