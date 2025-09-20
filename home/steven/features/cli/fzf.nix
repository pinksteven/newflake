{
  lib,
  config,
  ...
}: {
  programs.fzf = {
    enable = true;
    defaultOptions = lib.mkIf (!config.stylix.enable) ["--color 16"];
  };
}
