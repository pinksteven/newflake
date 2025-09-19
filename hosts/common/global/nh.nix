{inputs, ...}: {
  programs.nh = {
    enable = true;
    flake = "~/Documents/newflake";
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 3 --keep-since 3d";
    };
  };
}
