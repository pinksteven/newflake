{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/steven
    ../common/optional/tailscale-exit-node.nix

    # Disabled untill the machine gets deployed
    # ./services/couchdb.nix # For obisidian livesync
    # ./services/forgejo.nix
    # ./services/grafana.nix
    # ./services/prometheus.nix
    # ./services/radicale.nix
    # ./services/tailscale-serve.nix
    # ./services/wakapi.nix
  ];

  networking = {
    hostName = "kaermorhen";
    useDHCP = true;
    dhcpcd.IPv6rs = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };
  hardware.graphics.enable = true;

  # Hardware capabilities for home-manager modules
  hardware.capabilities = {
    hasBattery = false;
    hasBluetooth = false;
    hasWifi = false;
  };

  system.stateVersion = "25.05";
}
