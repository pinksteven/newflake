{config, ...}: {
  sops.secrets = {
    "mc-server/rcon_password" = {
      sopsFile = ../secrets.yaml;
    };
  };
  networking.firewall = {
    allowedUDPPorts = [25565 24454];
    allowedTCPPorts = [25565];
  };
  virtualisation.oci-containers.containers.mc-server = {
    image = "itzg/minecraft-server:latest";
    pull = "newer";
    autoStart = true;

    volumes = ["/srv/mc-server:/data"];
    ports = ["25565:25565" "24454:24454/udp"];

    environment = {
      EULA = "TRUE";
      TYPE = "NEOFORGE";
      VERSION = "1.21.1";
      MEMORY = "8192M";
      MAX_PLAYERS = "10";
      USE_MEOWICE_FLAGS = "true";
      TZ = "Europe/Warsaw";
      DIFFICULTY = "2";
      SPAWN_PROTECTION = "0";
      REGION_FILE_COMPRESSION = "lz4";
      ENABLE_WHITELIST = "true";
      VANILLATWEAKS_SHARECODE = "e3C092\nwkxjVD";
      ALLOW_FLIGHT = "true";
      MOTD = "\\u00a7l   \\u00a7r           \\u00a76\\u00a7l\\u00a7kbuh\\u00a7d Greetings traveler! \\u00a76\\u00a7l\\u00a7kbuh\\u00a7r\\n\\u00a7l   \\u00a7r @me on discord for whitelist if you can't join";
    };
    environmentFiles = [config.sops.secrets."mc-server/rcon_password".path];

    extraOptions = [
      "--cpu-shares=256"
      "--memory=9g"
      "--no-healthcheck"
    ];
  };
}
