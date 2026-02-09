{
  lib,
  osConfig,
  ...
}: let
  monitorToConfig = m: ''
    output "${m.name}" {
    ${
      if !(m.enabled)
      then "off"
      else ""
    }
    ${
      if m.primary
      then "focus-at-startup"
      else ""
    }
    mode "${toString m.width}x${toString m.height}@${toString (m.refreshRate * 1.0)}"
    scale ${toString m.scale}
    ${
      if m.transform.rotation != 0
      then "transform \"${
        if m.transform.flipped
        then "flipped-"
        else ""
      }${toString m.transform.rotation}\""
      else ""
    }
    ${
      if m.position != null
      then "position x=${toString m.position.x} y=${toString m.position.y}"
      else ""
    }
    ${
      if m.vrr
      then "variable-refresh-rate on-demand=true"
      else ""
    }
    }
  '';
  portraitMonitor =
    lib.findFirst
    (m: !(m.primary or false) && ((m.transform.rotation or 0) == 90 || (m.transform.rotation or 0) == 270))
    null
    osConfig.monitors;

  primaryMonitor = lib.head (lib.filter (m: m.primary) osConfig.monitors);
in {
  xdg.configFile."niri/outputs.kdl".text =
    lib.concatMapStringsSep "\n" (monitor: monitorToConfig monitor) osConfig.monitors
    + ''
      workspace "primary" { open-on-output "${primaryMonitor.name}"; }
      workspace "media" ${
        if portraitMonitor != null
        then "{ open-on-output \" + portraitMonitor.name + \"; }"
        else ""
      }

      spawn-sh-at-startup "niri msg action focus-workspace \"primary\""
    '';
}
