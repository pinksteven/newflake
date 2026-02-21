{
  services.syncthing = {
    enable = true;
    openDefaultPorts = false;
    systemService = true;
    guiAddress = "0.0.0.0:8384";
  };
}
