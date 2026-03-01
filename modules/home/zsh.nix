{ ... }:

{
  home.file = {
    ".zshenv".source = ../../zsh/.zshenv;
    ".hushlogin".source = ../../zsh/.hushlogin;
    ".config/zsh/.zshrc".source = ../../zsh/.config/zsh/.zshrc;
    ".config/zsh/aliases".source = ../../zsh/.config/zsh/aliases;
    ".config/zsh/path".source = ../../zsh/.config/zsh/path;
    ".config/zsh/extras".source = ../../zsh/.config/zsh/extras;
  };
}
