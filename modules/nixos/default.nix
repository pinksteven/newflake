{
  monitors = import ./monitors.nix;
  base16-theme = import ./base16-theme.nix;
  fontProfiles = import ../shared/fontProfiles.nix;
  gamingReady = import ./gaming.nix;
  hardwareCapabilities = import ./hardware-capabilities.nix;
}
