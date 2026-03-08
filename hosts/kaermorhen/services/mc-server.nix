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
    ports = ["25565:25565" "24454:24454"];

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
    };
    environmentFiles = [config.sops.secrets."mc-server/rcon_password".path];

    extraOptions = [
      "--cpu-shares=256"
      "--memory=9g"
      "--no-healthcheck"
    ];
  };
}
