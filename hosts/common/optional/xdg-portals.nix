{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-termfilechooser
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common.default = ["termfilechooser" "gtk"];
      niri = {
        default = ["termfilechooser" "gnome" "gtk"];
        "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
      };
    };
  };
}
