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

  # Create a small "game-run" wrapper (to be replaced with scopebuddy)
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "game-run" ''
      exec gamemoderun gamescope "$@"
    '')
  ];

  programs = {
    gamescope = {
      enable = true;
      enableWsi = true;
      # capSysNice = true;
      # To be replaced with scopebuddy
      args = let
        monitor = lib.head (lib.filter (m: m.primary) config.monitors);
      in [
        "-W ${toString monitor.width}"
        "-H ${toString monitor.height}"
        "-w ${toString monitor.width}"
        "-h ${toString monitor.height}"
        "--fullscreen"
      ];
      # ++ lib.optional monitor.hdr "--hdr-enabled"
      # ++ lib.optional monitor.vrr "--adaptive-sync";
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
      };
    };
  };
}
