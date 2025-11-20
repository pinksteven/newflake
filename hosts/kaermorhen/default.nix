{inputs, ...}: {
  imports = [
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ./services

    ../common/global
    ../common/users/steven
    ../common/optional/tailscale-exit-node.nix
  ];

  networking = {
    hostName = "kaermorhen";
    useDHCP = true;
    dhcpcd.IPv6rs = true;
  };

  # Hardware capabilities for home-manager modules
  hardware.capabilities = {
    hasBattery = false;
    hasBluetooth = false;
  };

  system.stateVersion = "25.05";
}
