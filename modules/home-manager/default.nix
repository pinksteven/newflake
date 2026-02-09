{
  wallpaper = import ./wallpaper.nix;
  fontProfiles = import ../shared/fontProfiles.nix;
  cursor = import ./cursor.nix;
  opacity = import ./opacity.nix;
  startup = import ./startup.nix;
}
