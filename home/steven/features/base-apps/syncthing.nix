{
  services.syncthing = {
    enable = true;
  };

  home.persistence."/persist/home/steven" = {
    directories = [".local/state/syncthing"];
  };
}
