# So i might be able to setup the entire gaming config via home-manager
# but there already is a lot of configuration options to do this on nixos level
# and this way is much easier so i will just use this instead
{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: {
  gamingReady = true;

  imports = [inputs.nix-gaming.nixosModules.platformOptimizations];

  programs = {
    gamescope = {
      enable = true;
      args = let
        monitor = lib.head (lib.filter (m: m.primary) config.monitors);
      in
        [
          "--output-width ${toString monitor.width}"
          "--output-height ${toString monitor.height}"
          "--nested-refresh ${toString monitor.refreshRate}"
          "--prefer-output ${monitor.name}" # Doesn't do shit for nested gamescope
          "--fullscreen"
        ]
        ++ lib.optional monitor.hdr "--hdr-enabled"
        ++ lib.optional monitor.vrr "--adaptive-sync";
    };
    steam = {
      enable = true;
      localNetworkGameTransfers.openFirewall = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extest.enable = true;
      protontricks.enable = true;
      platformOptimizations.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };
    gamemode = {
      enable = true;
      settings = {
        general = {
          softrealtime = "on";
          inhibit_screensaver = 1;
        };
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = lib.mkDefault 0;

          # NVIDIA specific
          nv_powermizer_mode = 1;
          # AMD specific
          amd_performance_level = "high";
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };
  };
  systemd.services."gaming-suspend-fix" = let
    # What to freeze with pkill -STOP
    freezeProcesses = [
      "steam"
      "steam-run"
      "pressure-vessel"
      "steamwebhelper"
    ];

    freezeScript = ''
      ${lib.concatMapStringsSep "\n" (
          proc: ''echo "Freezing ${proc}..."; ${pkgs.procps}/bin/pkill -STOP -f "${proc}" || true''
        )
        freezeProcesses}
      sleep 1
    '';

    unfreezeScript = ''
      ${lib.concatMapStringsSep "\n" (
          proc: ''echo "Unfreezing ${proc}..."; ${pkgs.procps}/bin/pkill -CONT -f "${proc}" || true''
        )
        freezeProcesses}
    '';
  in {
    description = "Freeze Steam before suspend to avoid blocking";
    before = ["sleep.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "freeze-fhs-groups" ''
        # Freeze entire process groups for FHS environments
        for pattern in "steam-run" "\.steam-wrapped"; do
          for pid in $(${pkgs.procps}/bin/pgrep -f "$pattern"); do
            pgid=$(${pkgs.procps}/bin/ps -o pgid= -p "$pid" 2>/dev/null | tr -d ' ')
            if [ -n "$pgid" ] && [ "$pgid" -gt 1 ]; then
              echo "Freezing FHS process group: $pgid"
              kill -STOP -"$pgid" 2>/dev/null || true
            fi
          done
        done
      '';
      ExecStop = pkgs.writeShellScript "unfreeze-fhs-groups" ''
        for pattern in "steam-run" "\.steam-wrapped"; do
          for pid in $(${pkgs.procps}/bin/pgrep -f "$pattern"); do
            pgid=$(${pkgs.procps}/bin/ps -o pgid= -p "$pid" 2>/dev/null | tr -d ' ')
            if [ -n "$pgid" ] && [ "$pgid" -gt 1 ]; then
              kill -CONT -"$pgid" 2>/dev/null || true
            fi
          done
        done
      '';
    };
    wantedBy = ["sleep.target"];
  };
}
