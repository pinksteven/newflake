{lib, ...}: let
  inherit (lib) types mkOption;
  mkFontOption = kind: {
    name = mkOption {
      type = types.str;
      default = null;
      description = "Family name for ${kind} font profile";
      example = "Fira Code";
    };
    package = mkOption {
      type = types.package;
      default = null;
      description = "Package for ${kind} font profile";
      example = "pkgs.fira-code";
    };
  };
  mkSizeOption = kind:
    mkOption {
      type = types.int;
      default = 12;
      description = "Default ${kind} font size";
      example = 16;
    };
in {
  options.fonts = {
    monospace = mkFontOption "monospace";
    sansSerif = mkFontOption "sansSerif";
    serif = mkFontOption "serif";
    emoji = mkFontOption "emoji";
    sizes = {
      applications = mkSizeOption "applications";
      desktop = mkSizeOption "desktop";
      popups = mkSizeOption "popups";
      terminal = mkSizeOption "terminal";
    };
  };
}
