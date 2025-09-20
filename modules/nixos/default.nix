{
  monitors = import ./monitors.nix;
  base16-theme = import ./base16-theme.nix;
  fontProfiles = import ./fonts.nix;
  gamingReady = import ./gaming.nix;
  hyprland = import ./hyprland.nix;
}
