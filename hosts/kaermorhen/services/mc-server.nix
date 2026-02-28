{
  networking.firewall = {
    allowedUDPPorts = [25565 24454];
    allowedTCPPorts = [25565];
  };
  virtualisation.oci-containers.containers.mc-server = {
    image = "itzg/minecraft-server:latest";
    autoStart = true;

    ports = ["25565:25565" "24454:24454"];
    volumes = ["/srv/mc-server:/data"];

    environment = {
      EULA = "TRUE";
      TYPE = "MODRINTH";
      MEMORY = "8192M";
      MAX_PLAYERS = "10";
      USE_MEOWICE_FLAGS = "true";
      TZ = "Europe/Warsaw";
      DIFFICULTY = "2";
      SPAWN_PROTECTION = "0";
      REGION_FILE_COMPRESSION = "lz4";
      ENABLE_WHITELIST = "true";
      ALLOW_FLIGHT = "true";
      RCON_PASSWORD = "";
    };

    extraOptions = [
      "--cpus=4"
      "--cpu-shares=512"
      "--memory=8g"
    ];
  };
}
