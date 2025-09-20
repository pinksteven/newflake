{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) types mkOption;
in {
  options.cursor = {
    name = mkOption {
      type = types.nullOr types.str;
      default = "Bibata-Modern-Ice";
      description = "Name of cursor theme to use";
      example = "Bibata-Modern-Ice";
    };
    package = mkOption {
      type = types.nullOr types.package;
      default = pkgs.bibata-cursors;
      description = "Package for cursor theme";
      example = "pkgs.bibata-cursors";
    };
    size = mkOption {
      type = types.nullOr types.int;
      default = 24;
      description = "Cursor size";
      example = 24;
    };
  };
}
