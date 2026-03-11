{
  services.forgejo = {
    enable = true;
    lfs.enable = true;
    settings = {
      server = {
        HTTP_PORT = 2137;
      };
    };
  };
}
