{pkgs, ...}: {
  services.trayscale = {
    enable = true;
    hideWindow = true;
  };
  # The trayscale module is wierd and doesn't "install" trayscale
  # so it's not in path, and i don't like that
  home.packages = with pkgs; [trayscale];
}
