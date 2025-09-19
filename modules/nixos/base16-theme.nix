{lib, ...}: let
  inherit (lib) types mkOption;
in {
  options.base16-theme = mkOption {
    type = types.nullOr types.path;
    default = null;
    description = "Stylix compatible theme to use for system theming";
  };
}
