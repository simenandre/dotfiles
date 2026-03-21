{ ... }:

{
  home.file.".config/ghostty/config".text = ''
    theme = tokyonight-storm

    window-padding-x = 12
    window-padding-y = 12
    window-decoration = true
    window-theme = "dark"
    window-inherit-working-directory = true
    window-inherit-font-size = true
  '';
}
