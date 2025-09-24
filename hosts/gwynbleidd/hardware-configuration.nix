{
  lib,
  config,
  inputs,
  ...
}: {
  nixpkgs.hostPlatform = "x86_64-linux";
  imports = [
    inputs.disko.nixosModules.disko
    ../common/optional/ephemeral-btrfs.nix
  ];
  hardware.cpu.amd.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "ondemand";

  boot = {
    kernelModules = ["kvm-amd"];
    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [];
      luks.devices = {
        cryptroot = {
          device = "/dev/disk/by-label/${config.networking.hostName}";
          allowDiscards = true; # Used if primary device is a SSD
        };
      };
    };
    extraModulePackages = [];
  };
  networking.useDHCP = lib.mkDefault true;

  hardware.nvidia = {
    modesetting.enable = true;

    # Experimental power management (might fix sleep issues)
    powerManagement = {
      enable = false;
      finegrained = false;
    };

    # Graphics card here is 3070, as so it is recommended to use
    open = true;

    # Just to be sure it grabs newest drivers
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  disko.devices.disk = let
    inherit (config.networking) hostName;
  in {
    # Same formatting as zireael, so also From Misterio77, only different device path and larger swap
    main = {
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
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = hostName;
              settings.allowDiscards = true;
              content = let
                this = config.disko.devices.disk.main.content.partitions.luks.content.content;
              in {
                type = "btrfs";
                extraArgs = ["-L${hostName}"];
                postCreateHook = ''
                  MNTPOINT=$(mktemp -d)
                  mount -t btrfs "${this.device}" "$MNTPOINT"
                  trap 'umount $MNTPOINT; rm -d $MNTPOINT' EXIT
                  btrfs subvolume snapshot -r $MNTPOINT/root $MNTPOINT/root-blank
                '';
                subvolumes = {
                  "/root" = {
                    mountOptions = ["compress=zstd"];
                    mountpoint = "/";
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
                    mountOptions = ["compress=zstd" "noatime"];
                    mountpoint = "/swap";
                    swap.swapfile = {
                      size = "32768M";
                      path = "swapfile";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
    # A 2TB drive i use mainly to store games
    games = {
      device = "/dev/nvme1n1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          main = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = ["-L BIGDISK"];
              mountpoint = "/mnt/bigdisk";
              mountOptions = ["compress=zstd" "noatime" "rw" "auto" "users" "exec"];
              postMountHook = ''
                chown -R :users /mnt/bigdisk
                chmod 775 /mnt/bigdisk
              '';
            };
          };
        };
      };
    };
  };
  fileSystems."/persist".neededForBoot = true;
}
