{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.niri-flake.homeModules.niri
    inputs.niri-flake.homeModules.stylix
  ];

  xdg = {
    autostart.enable = true;
    mime.enable = true;
  };

  services.gnome-keyring.enable = lib.mkForce false;

  programs.niri = {
    enable = true;
    package = pkgs.niri-stable;

    settings = {
      binds."Mod+T".action.spawn = "ghostty";
    };
  };
}
