{lib, ...}: {
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = lib.mkForce false;
    grub = {
      enable = lib.mkForce true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  };
}
