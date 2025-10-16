{pkgs, ...}: {
  home.file.".config/xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=yazi-wrapper.sh
    default_dir=$HOME/Downloads
    ; Uncomment and edit the line below to change the terminal emulator command
    env=TERMCMD=kitty --class=yazi.xdg
  '';
  home.file.".config/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh".source = "${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh";

  xdg.portal = {
    extraPortals = [pkgs.xdg-desktop-portal-termfilechooser];
    config = {
      common.default = ["termfilechooser" "gtk"];
      niri = {
        default = ["termfilechooser" "gnome" "gtk"];
        "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
      };
    };
  };
}
