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
          "--prefer-output ${monitor.name}" # Doesn't do shit for nested gamescope
          "--force-grab-cursor"
          "--nested-unfocused-refresh 30"
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
}
