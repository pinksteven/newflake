{
  lib,
  config,
  ...
}: let
  hasStylix = lib.attrByPath ["stylix" "enable"] false config;
in {
  programs.fzf = {
    enable = true;
    defaultOptions = lib.mkIf (!hasStylix) ["--color 16"];
  };
}
