{
  config,
  pkgs,
  ...
}: {
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };
  environment.systemPackages = [pkgs.tpm2-tss];
  boot.kernelModules = ["uhid"];
  # Needed for tpm-fido
  services.udev.extraRules = ''
    KERNEL=="uhid", SUBSYSTEM=="misc", GROUP="${config.security.tpm2.tssGroup}", MODE="0660"
  '';
}
