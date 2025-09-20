{lib, ...}: let
  inherit (lib) types mkOption;
  mkOpacityOption = kind:
    mkOption {
      type = types.float;
      default = 1.0;
      description = "Default ${kind} opacity";
      example = 0.8;
    };
in {
  options.opacity = {
    applications = mkOpacityOption "applications";
    desktop = mkOpacityOption "desktop";
    popups = mkOpacityOption "popups";
    terminal = mkOpacityOption "terminal";
  };
}
