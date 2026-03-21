{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMCyUn5BfmAnd/6xi0X1mYF/+jPOmCS0bpNUePF55gCY";
      signByDefault = true;
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
      push.autoSetupRemote = true;
      gpg.format = "ssh";
      "gpg \"ssh\"".program =
        if pkgs.stdenv.isDarwin
        then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
        else "/opt/1Password/op-ssh-sign";
      github.user = "simenandre";
      pull.rebase = true;
      "url \"ssh://git@github.com/\"".insteadOf = "https://github.com/";
      commit.gpgsign = true;
    };
  };
}
