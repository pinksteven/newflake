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
    ../common/optional/gamemode.nix
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
      brightnessKeys = {enable = true;};
    };
    dconf.enable = true;
  };
  environment.systemPackages = [pkgs.brightnessctl];

  # Lid settings
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "lock";
    HandlePowerKey = "suspend";
    HandlePowerKeyLongPress = "poweroff";
  };

  hardware.graphics.enable = true;

  monitors = [
    {
      name = "eDP-1";
      width = 2256;
      height = 1504;
      workspace = "1";
      primary = true;
      refreshRate = 60;
      scale = "1.5";
    }
  ];

  base16-theme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";

  system.stateVersion = "25.05";
}
