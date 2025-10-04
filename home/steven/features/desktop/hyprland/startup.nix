{
  monitors,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings.exec-once = let
    primaryMonitor = lib.head (lib.filter (m: m.primary) monitors);
  in [
    "hyprctl dispath focusmonitor ${primaryMonitor.name}"
  ];
}
