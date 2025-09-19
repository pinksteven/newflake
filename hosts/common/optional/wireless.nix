{
  hardware.bluetooth = {
    enable = true;
  };

  networking.networkmanager = {
    enable = true;
  };

  environment.persistence."/persist".directories = [
    "/etc/NetworkManager/system-connections"
    "/var/lib/bluetooth"
  ];
}
