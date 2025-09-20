{
  lib,
  config,
  ...
}: let
  hostname = config.networking.hostName;
  wipeScript = ''
    mkdir /btrfs_tmp
    mount /dev/disk/by-label/${hostname} /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(ls -1t /btrfs_tmp/old_roots | tail -n +6); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume snapshot /btrfs_tmp/root-blank /btrfs_tmp/root
    umount /btrfs_tmp
  '';
  phase1Systemd = config.boot.initrd.systemd.enable;
in {
  fileSystems."/" = lib.mkDefault {
    device = "/dev/disk/by-label/${hostname}";
    fsType = "btrfs";
    options = [
      "subvol=root"
      "compress=zstd"
    ];
  };
  boot.initrd = {
    supportedFilesystems = ["btrfs"];
    postResumeCommands = lib.mkIf (!phase1Systemd) (lib.mkAfter wipeScript);
    systemd.services.restore-root = lib.mkIf phase1Systemd {
      description = "Rollback btrfs rootfs";
      wantedBy = ["initrd.target"];
      requires = ["dev-disk-by\\x2dlabel-${hostname}.device"];
      after = [
        "dev-disk-by\\x2dlabel-${hostname}.device"
        "systemd-cryptsetup@${hostname}.service"
      ];
      before = ["sysroot.mount"];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = wipeScript;
    };
  };

  fileSystems = {
    "/nix" = lib.mkDefault {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = [
        "subvol=nix"
        "noatime"
        "compress=zstd"
      ];
    };

    "/persist" = lib.mkDefault {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = [
        "subvol=persist"
        "compress=zstd"
      ];
      neededForBoot = true;
    };

    "/swap" = lib.mkDefault {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = [
        "subvol=swap"
        "noatime"
      ];
    };
  };
}
