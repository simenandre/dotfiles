{ pkgs, ... }:

let
  zsh-autocomplete = pkgs.fetchFromGitHub {
    owner = "marlonrichert";
    repo = "zsh-autocomplete";
    rev = "main";
    hash = "sha256-KYey9sidz8VzgfM9YVaCsVXpKKdCjSHk3tuadQz9Re0=";
  };
  zsh-autosuggestions = pkgs.fetchFromGitHub {
    owner = "zsh-users";
    repo = "zsh-autosuggestions";
    rev = "master";
    hash = "sha256-KmkXgK1J6iAyb1FtF/gOa0adUnh1pgFsgQOUnNngBaE=";
  };
  zsh-vi-mode = pkgs.fetchFromGitHub {
    owner = "jeffreytse";
    repo = "zsh-vi-mode";
    rev = "master";
    hash = "sha256-WdZHCVxVVOs4HyG5f56vAA17UWYOvb9Yf6v7M1RIdU4=";
  };
in
{
  home.file = {
    ".zsh_repos/marlonrichert/zsh-autocomplete".source = zsh-autocomplete;
    ".zsh_repos/zsh-users/zsh-autosuggestions".source = zsh-autosuggestions;
    ".zsh_repos/jeffreytse/zsh-vi-mode".source = zsh-vi-mode;
    ".zshenv".text = ''
      ##!/bin/zsh
      #
      # .zshenv - Zsh environment file, loaded always.
      #

      # Set ZDOTDIR if you want to re-home Zsh.
      export XDG_CONFIG_HOME=''${XDG_CONFIG_HOME:-$HOME/.config}
      export XDG_DATA_HOME=''${XDG_DATA_HOME:-$HOME/.local/share}
      export XDG_CACHE_HOME=''${XDG_CACHE_HOME:-$HOME/.cache}
      export ZDOTDIR=''${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}

      # Ensure path arrays do not contain duplicates.
      typeset -gU path fpath

      # Set the list of directories that zsh searches for commands.
      path=(
        $HOME/{,s}bin(N)
        $HOME/.local/{,s}bin(N)
        /opt/{homebrew,local}/{,s}bin(N)
        /usr/local/{,s}bin(N)
        $path
      )
    '' + (
      if pkgs.stdenv.isDarwin then ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '' else ""
    ) + ''
      [ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
    '';

    ".hushlogin".text = "";

    ".config/zsh/.zshrc".text = ''
      #!/bin/bash
      #      ^----- get shellcheck hints based on bash
      # https://github.com/koalaman/shellcheck/issues/809
      # shellcheck disable=SC1090 # sourced filenames with variables

      eval "$(starship init zsh)"

      source ~/.zsh_repos/marlonrichert/zsh-autocomplete/zsh-autocomplete.plugin.zsh
      source ~/.zsh_repos/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
      source ~/.zsh_repos/jeffreytse/zsh-vi-mode/zsh-vi-mode.plugin.zsh

      for file in ~/.config/zsh/{aliases,path,extras}; do
          if [[ -r "$file" ]] && [[ -f "$file" ]]; then
              # shellcheck source=/dev/null
              source "$file"
          fi
      done

      command -v twm &>/dev/null && eval "$(twm --print-zsh-completion)"

      bindkey '^I^I' autosuggest-accept
    '';

    ".config/zsh/aliases".text = ''
      # Git aliases
      alias git-unpushed='git log --branches --not --remotes --no-walk --decorate --oneline'
      alias gb='git checkout -b'
      alias gfr='git fetch upstream && git rebase upstream/main'
      alias git-undo='git reset --soft HEAD~1'
      alias git-clean-branches="git for-each-ref --format '%(refname:short)' refs/heads | grep -v 'master\|main' | xargs git branch -D"
      alias :q='exit'
      alias ls='ls --color'
    '' + (if pkgs.stdenv.isDarwin then ''
      alias tailscale='/Applications/Tailscale.app/Contents/MacOS/Tailscale'
    '' else "") + ''

      # Generic / Random / Utility
      alias rg="rg --hidden --glob '!.git' --glob '!node_modules'"
      alias r='cd $REPOS/github.com/'
      alias c='clear'
    '' + (if pkgs.stdenv.isDarwin then ''
      alias afk='pmset displaysleepnow'
    '' else "") + ''
      alias dl="cd ~/Downloads"
      alias l='ls -l'
      alias todo='nt'
      alias tasks="open 'obsidian://open?file=-%20Oppgaver'"
      alias todos="mt ~/ghq/github.com/simenandre/notes/"
      alias today="open 'obsidian://advanced-uri?daily=true'"
      alias tre="tree -I '.git|node_modules'"
      alias timeliste="open 'https://tripletex.no/execute/updateHourlist?contextId=11208568'"
      alias t="open 'https://tripletex.no/execute/updateHourlist?contextId=11208568'"
      alias fork-cleaner="fork-cleaner --token \$(cat ~/.secrets/github-token 2>/dev/null)"
      alias vi="nvim"
      alias vim="nvim"
      alias v="nvim"

      alias dump-issues="getBjerkIssues > ~/Downloads/issues-$(date -I).json"
    '';

    ".config/zsh/path".text = ''
      #!/bin/bash

      # Add directories to the PATH and prevent to add the same directory multiple times upon shell reload.
      add_to_path() {
        if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
          export PATH="$1:$PATH"
        fi
      }

      add_to_path "$HOME/.volta/bin"
      add_to_path "/Library/Frameworks/Firebird.framework/Resources/bin"
      add_to_path "/opt/homebrew/opt/libpq/bin"
    '';

    ".config/zsh/extras".text = ''
      NOTES_DIR=$HOME/ghq/github.com/simenandre/notes/
      function note() {
        if [ $1 ]; then
          FILE=$NOTES_DIR/$(date +%Y-%m-%d).md

          if [ $2 ]; then
            FILE=$2
          fi

          echo $1 >> $FILE
        fi
      }

      function nt() {
        if [ $1 ]; then
          CONTENT="- [ ] $1"
          note $CONTENT $2
        fi
      }

      function getBjerkIssues() {
        gh issue list --repo bjerkio/internal \
          --search "-label:backlog -label:kind/system" \
          --json title,body,url,createdAt,assignees,number,labels,comments \
          --jq 'map({url, createdAt, title, labels: [.labels[].name], assignees: [.assignees[].login], body, number: "#\(.number)", comments: .comments | map({ body: .body, createdAt: .createdAt })})'
      }

      function g() {
        export GOOGLE_CLOUD_PROJECT="sokkel-sandbox"
        export GOOGLE_CLOUD_LOCATION="europe-north1"
        export GOOGLE_GENAI_USE_VERTEXAI=true

        gemini
      }
    '';
  };
}
