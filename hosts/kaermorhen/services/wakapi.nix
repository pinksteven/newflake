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
    settings = {
      app = {
        leaderboard_enabled = false;
      };
      security = {
        allow_signup = false;
        invite_codes = true;
        disable_frontpage = true;
      };
    };
  };
}
