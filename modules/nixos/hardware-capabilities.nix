{lib, ...}: {
  options.hardware.capabilities = {
    hasBattery = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether the system has a battery (laptop/portable device)";
    };

    hasBluetooth = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether the system has Bluetooth capability";
    };

    hasWifi = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether the system has WiFi capability";
    };
  };
}
