{config, ...}: {
  stylix = {
    enable = true;
    inherit (config) opacity cursor;
    fonts = config.fontProfiles;
    image = config.wallpaper;
    colorGeneration = {
      scheme = "content";
    };
  };
}
