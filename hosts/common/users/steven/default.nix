{
  pkgs,
  config,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.steven = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups =
      ifTheyExist
      [
        "audio"
        "docker"
        "git"
        "i2c"
        "libvirtd"
        "network"
        "plugdev"
        "podman"
        "tss"
        "video"
        "wheel"
        "networkmanager"
        "gamemode"
        "bluetooth"
      ];
    hashedPasswordFile = config.sops.secrets."passwords/steven".path;
    packages = [pkgs.home-manager];
  };

  sops.secrets."passwords/steven" = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  home-manager.users.steven = import ../../../../home/steven/${config.networking.hostName}.nix;
}
