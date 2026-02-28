{config, ...}:{
sops.secrets = {
  "couchdb/admin".sopsFile = {
    mode = "0600";
    owner = config.services.couchdb.user;
    sopsFile = ../secrets.yaml;
  };
  services.couchdb = {
    enable = true;
    extraConfigFiles = [config.sops.secrets."couchdb/admin".path];
  };
}
