{config, ...}: {
  sops.secrets = {
    "wakapi/salt" = {
      mode = "0600";
      owner = "wakapi";
      sopsFile = ../secrets.yaml;
    };
  };
  services.wakapi = {
    enable = true;
    environmentFiles = [config.sops.secrets."wakapi/salt".path];
    database = {
      dialect = "sqlite3";
    };
  };
}
