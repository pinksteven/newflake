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
    passwordSaltFile = config.sops.secrets."wakapi/salt".path;
  };
}
