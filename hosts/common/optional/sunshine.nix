{
  pkgs,
  config,
  lib,
  ...
}: let
  monitors = config.monitors;
  primary = lib.head (lib.filter (m: m.primary) monitors);
  toTransform = m:
    if m.transform.rotation != 0
    then "transform \"${
      if m.transform.flipped
      then "flipped-"
      else ""
    }${toString m.transform.rotation}\""
    else "";

  doDisableNonPrimary =
    lib.concatMapStringsSep "\n" (
      m:
        lib.optionalString (m.name != primary.name && (m.enabled or true)) ''
          niri msg output "${m.name}" off || true
        ''
    )
    monitors;

  # Restore all configured monitors on undo
  undoRestoreAll =
    lib.concatMapStringsSep "\n" (
      m: let
        enabled = m.enabled or true;
        rr = toString (m.refreshRate or 60);
        scale = toString (m.scale or 1.0);
        x = toString (m.position.x or 0);
        y = toString (m.position.y or 0);
        transform = toTransform m;
        vrrOn = m.vrr or false;
      in
        if enabled
        then ''
          niri msg output "${m.name}" on || true
          niri msg output "${m.name}" mode "${toString m.width}x${toString m.height}@${rr}" || true
          niri msg output "${m.name}" scale "${scale}" || true
          niri msg output "${m.name}" position "${x}" "${y}" || true
          niri msg output "${m.name}" transform "${transform}" || true
          niri msg output "${m.name}" vrr ${
            if vrrOn
            then "on"
            else "off"
          } || true
        ''
        else ''
          niri msg output "${m.name}" off || true
        ''
    )
    monitors;

  prepcmd = pkgs.writeShellScriptBin "sunshine-global-prep" ''
    set -euo pipefail

    ACTION="${"$"}{1:-}"
    STREAM_WIDTH="${"$"}{SUNSHINE_CLIENT_WIDTH:-1280}"
    STREAM_HEIGHT="${"$"}{SUNSHINE_CLIENT_HEIGHT:-720}"
    STREAM_FPS="${"$"}{SUNSHINE_CLIENT_FPS:-60}"


    # Exit quietly if not niri
    if [[ "''${XDG_CURRENT_DESKTOP:-}" != *niri* ]] \
        && [[ "''${XDG_SESSION_DESKTOP:-}" != *niri* ]] \
        && ! pgrep -x niri >/dev/null 2>&1; then
      exit 0
    fi

    if ! command -v niri >/dev/null 2>&1; then
      echo "[sunshine-prep-cmd] niri not found" >&2
      exit 1
    fi

    case "$action" in
          do)
            w="''${SUNSHINE_CLIENT_WIDTH:-}"
            h="''${SUNSHINE_CLIENT_HEIGHT:-}"
            fps="''${SUNSHINE_CLIENT_FPS:-60}"

            if [[ -z "$w" || -z "$h" ]]; then
              echo "[sunshine-prep-cmd] Missing SUNSHINE_CLIENT_WIDTH/HEIGHT" >&2
              exit 1
            fi

            # Disable non-primary outputs
            ${doDisableNonPrimary}

            # Set primary output to stream mode
            niri msg output "${primary.name}" on
            niri msg output "${primary.name}" mode "$w"x"$h"@"$fps"

            # Keep configured geometry/scale/transform on primary
            niri msg output "${primary.name}" scale "${toString (primary.scale or 1.0)}"
            niri msg output "${primary.name}" position "${toString (primary.position.x or 0)}" "${toString (primary.position.y or 0)}"
            niri msg output "${primary.name}" transform "${toTransform primary}"
            ;;
          undo)
            # Restore your declarative monitor state from config.monitors
            ${undoRestoreAll}
            ;;
          *)
            echo "Usage: sunshine-prep-cmd do|undo" >&2
            exit 1
            ;;
        esa
  '';
in {
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;

    settings = {
      locale = "en";
      sunshine_name = config.networking.hostName;
      global_prep_cmd = ''
        [
          {
            "do":"${lib.getExe prepcmd} do",
            "elevated":true,
            "undo":"${lib.getExe prepcmd} undo",
            "undoElevated":true
          }
        ]
      '';
      output_name =
        if (config.networking.hostName == "gwynbleidd")
        then "1"
        else "0";
      nvenc_spatial_aq = "enabled"; # I assume i will stream at low bitrates
    };
  };
}
