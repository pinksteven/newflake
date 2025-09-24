{
  lib,
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
        "users"
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
    openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/steven/id_masterkey.pub);
    hashedPasswordFile = config.sops.secrets."password/steven".path;
    packages = [pkgs.home-manager];
  };

  sops.secrets."password/steven" = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  home-manager.users.steven = import ../../../../home/steven/${config.networking.hostName}.nix;

  environment.persistence."/persist" = {
    users.steven = {};
  };
}
