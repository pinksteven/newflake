{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  nixpkgs.hostPlatform = "x86_64-linux";
  imports = [
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-cpu-intel

    inputs.disko.nixosModules.disko
    inputs.preload-ng.nixosModules.default
  ];
  hardware.cpu.intel.updateMicrocode = true;
  services.preload-ng.enable = true;
  powerManagement.cpuFreqGovernor = "ondemand";

  boot = {
    kernelModules = ["kvm-intel"];
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "vmd"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [];
    };
    kernelParams = [];
  };
  networking.useDHCP = lib.mkDefault true;

  disko.devices.disk.main = let
    inherit (config.networking) hostName;
  in {
    device = "/dev/nvme0n1";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        boot = {
          size = "1M";
          type = "EF02";
        };
        esp = {
          name = "ESP";
          size = "1G";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };
        root = {
          size = "100%";
          content = {
            type = "btrfs";
            extraArgs = ["-L${hostName}"];
            subvolumes = {
              "/rootfs" = {
                mountOptions = ["compress=zstd"];
                mountpoint = "/";
              };
              "/var" = {
                mountOptions = ["compress=zstd" "noatime" "autodefrag"];
                mountpoint = "/var";
              };
              "/nix" = {
                mountOptions = ["compress=zstd" "noatime"];
                mountpoint = "/nix";
              };
              "/persist" = {
                mountOptions = ["compress=zstd" "noatime"];
                mountpoint = "/persist";
              };
              "/swap" = {
                mountOptions = ["noatime"];
                mountpoint = "/swap";
                swap.swapfile = {
                  size = "16384M";
                  path = "swapfile";
                };
              };
            };
          };
        };
      };
    };
  };

  fileSystems = {
    "/persist".neededForBoot = true;
    "/var".neededForBoot = true;
  };

  environment.systemPackages = [
    pkgs.btrfs-progs
  ];

  systemd = {
    services.btrfs-snapshot = {
      description = "Create and prune Btrfs snapshots";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "btrfs-snapshot" ''
          set -euo pipefail

          DATE=$(date +%Y-%m-%d)
          SNAPDIR="/.snapshots"

          mkdir -p "$SNAPDIR"

          echo "Creating snapshots..."

          # Root snapshot
          if [ ! -d "$SNAPDIR/root-$DATE" ]; then
            btrfs subvolume snapshot -r / "$SNAPDIR/root-$DATE"
          fi

          # Var snapshot
          if [ ! -d "$SNAPDIR/var-$DATE" ]; then
            btrfs subvolume snapshot -r /var "$SNAPDIR/var-$DATE"
          fi

          echo "Pruning old snapshots..."

          cd "$SNAPDIR"

          # Keep last 14 root snapshots
          ls -1dt root-* 2>/dev/null | tail -n +15 | while read snap; do
            btrfs subvolume delete "$snap"
          done

          # Keep last 14 var snapshots
          ls -1dt var-* 2>/dev/null | tail -n +15 | while read snap; do
            btrfs subvolume delete "$snap"
          done
        '';
      };
    };

    timers.btrfs-snapshot = {
      description = "Daily Btrfs snapshot + prune";
      wantedBy = ["timers.target"];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };
    };
  };
}
