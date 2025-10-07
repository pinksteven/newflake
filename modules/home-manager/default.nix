{
  wallpaper = import ./wallpaper.nix;
  fontProfiles = import ../nixos/fonts.nix;
  cursor = import ./cursor.nix;
  opacity = import ./opacity.nix;
  startup = import ./startup.nix;
}
