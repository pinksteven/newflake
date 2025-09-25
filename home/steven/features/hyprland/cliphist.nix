{
  lib,
  pkgs,
  ...
}: let
  clipboard = pkgs.writeShellScriptBin "clipboard" ''
    cliphist list | ${lib.getExe pkgs.anyrun} --plugins ${pkgs.anyrun}/lib/libstdin.so | cliphist decode | wl-copy
  '';
in {
  wayland.windowManager.hyprland.settings.exec-once = [
    "uwsm app -- wl-paste -t text --watch cliphist store"
    "uwsm app -- wl-paste -t image --watch cliphist store"
  ];
  home.packages = with pkgs; [
    cliphist
    clipboard
  ];
}
