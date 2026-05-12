{config, ...}: {
  stylix = {
    enable = true;
    inherit (config) opacity cursor;
    base16Scheme = config.base16-theme;
    fonts = config.fontProfiles;
    image = config.wallpaper;
  };
}
