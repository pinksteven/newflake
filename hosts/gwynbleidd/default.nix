{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-gpu-nvidia-nonprime
    inputs.hardware.nixosModules.common-cpu-amd-pstate

    ./hardware-configuration.nix

    ../common/global
    ../common/users/steven

    ../common/optional/dualboot.nix
    ../common/optional/gaming.nix
    ../common/optional/greetd.nix
    ../common/optional/kdeconnect.nix
    ../common/optional/pipewire.nix
    ../common/optional/printer.nix
    ../common/optional/quietboot.nix
    ../common/optional/stylix.nix
    ../common/optional/wireless.nix
  ];

  networking.hostName = "gwynbleidd";

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    # Hopefully will fullscreen my tty without breaking graphical session
    # thanks to nvidia drivers i can't control monitors separately
    kernelParams = ["video=DP-2:1920x1080"];
  };

  programs = {
    dconf.enable = true;
  };

  hardware.graphics.enable = true;

  services = {
    ratbagd.enable = true;
    colord.enable = true;
    logind.settings.Login = {
      HandlePowerKey = "suspend";
      HandlePowerKeyLongPress = "poweroff";
    };
    pipewire.wireplumber.extraConfig = {
      "ga104-hdmi"."monitor.alsa.rules" = [
        {
          matches = [
            {
              "device.name" = "alsa_card.pci-0000_07_00.1";
            }
          ];
          actions = {
            update-props = {
              "device.profile" = "output:hdmi-stereo-extra1";
              "device.nick" = "Headphones";
              "device.description" = "Headphones";
            };
          };
        }
      ];
    };
  };

  monitors = [
    {
      name = "DP-2";
      width = 2560;
      height = 1440;
      position = {
        x = -2560;
        y = 240;
      };
      workspace = [1 2 3 4 5 6 7 8 9 10];
      primary = true;
      refreshRate = 144;
      scale = 1.0;
      hdr = true;
      vrr = true;
    }
    {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      transform.rotation = 270;
      workspace = [11 12 13 14 15 16 17 18 19 20];
      refreshRate = 60;
      scale = 1.0;
    }
  ];

  fileSystems."/mnt/bigdisk" = {
    device = "/dev/disk/by-label/bigdisk";
    fsType = "btrfs";
    options = ["noatime" "compress=zstd" "nofail"];
  };

  # Fix for nvidia not freeing up vram on niri
  environment.etc.
    "nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json".text =
    lib.mkIf (
      builtins.any
      (cfg: lib.attrByPath ["programs" "niri" "enable"] false cfg)
      (builtins.attrValues config.home-manager.users)
    ) # json
    
    ''
      {
          "rules": [
              {
                  "pattern": {
                      "feature": "procname",
                      "matches": "niri"
                  },
                  "profile": "Limit Free Buffer Pool On Wayland Compositors"
              }
          ],
          "profiles": [
              {
                  "name": "Limit Free Buffer Pool On Wayland Compositors",
                  "settings": [
                      {
                          "key": "GLVidHeapReuseRatio",
                          "value": 0
                      }
                  ]
              }
          ]
      }
    '';

  # Hardware capabilities for home-manager modules
  hardware.capabilities = {
    hasBattery = false;
    hasBluetooth = false;
  };

  base16-theme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";

  system.stateVersion = "25.05";
}
