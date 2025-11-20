{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.framework-13-7040-amd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/steven

    ../common/optional/greetd.nix
    ../common/optional/gaming.nix
    ../common/optional/kdeconnect.nix
    ../common/optional/quietboot.nix
    ../common/optional/pipewire.nix
    ../common/optional/printer.nix
    ../common/optional/stylix.nix
    ../common/optional/wireless.nix
    ../common/optional/secure-boot.nix
  ];

  networking.hostName = "zireael";

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  };

  powerManagement.powertop.enable = true;
  programs = {
    light = {
      enable = true;
    };
    dconf.enable = true;
  };
  environment.systemPackages = [pkgs.brightnessctl];

  # Lid settings
  services = {
    colord.enable = true;
    logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "lock";
      HandlePowerKey = "suspend";
      HandlePowerKeyLongPress = "poweroff";
    };
  };

  hardware.graphics.enable = true;

  monitors = [
    {
      name = "eDP-1";
      width = 2256;
      height = 1504;
      workspace = [1 2 3 4 5 6 7 8 9 10];
      primary = true;
      refreshRate = 60;
      scale = 1.5;
    }
  ];

  # Hardware capabilities for home-manager modules
  hardware.capabilities = {
    hasBattery = true;
    hasBluetooth = true;
  };

  base16-theme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";

  system.stateVersion = "25.05";
}
