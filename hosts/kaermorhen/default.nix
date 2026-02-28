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
    ./services/couchdb.nix # For obisidian livesync
    ./services/forgejo.nix
    ./services/grafana.nix
    # ./services/mc-server.nix
    ./services/prometheus.nix
    ./services/radicale.nix
    ./services/syncthing.nix
    ./services/wakapi.nix
    ./services/wol.nix
  ];

  networking.hostName = "kaermorhen";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Enable tailscale serve to access the services
  services.tailscale.serve.enable = true;

  # Hardware capabilities for home-manager modules
  hardware.capabilities = {
    hasBattery = false;
    hasBluetooth = false;
    hasWifi = false;
  };

  system.stateVersion = "25.05";
}
