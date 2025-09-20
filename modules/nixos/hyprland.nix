{
  config,
  lib,
  ...
}: let
  withHyprland =
    builtins.any (config: config.wayland.windowManager.hyprland.enable)
    (builtins.attrValues config.home-manager.users);
in {
  programs.hyprland = lib.mkIf withHyprland {
    enable = true;
    withUWSM = true;
  };
}
