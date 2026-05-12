{
  wallpaper = import ./wallpaper.nix;
  base16-theme = import ../shared/base16-theme.nix;
  fontProfiles = import ../shared/fontProfiles.nix;
  cursor = import ./cursor.nix;
  opacity = import ./opacity.nix;
  startup = import ./startup.nix;
}
