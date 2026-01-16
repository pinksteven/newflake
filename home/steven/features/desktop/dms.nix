{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
  ];
  # Basically using the wallpaper and panel part
  # plus some ipc commands
  programs.dankMaterialShell = {
    enable = true;
    enableSystemd = true;
    enableSystemMonitoring = false;
    enableClipboard = false; # I manage clipboard on my own
    enableDynamicTheming = false;
  };
  home.persistence."/persist" = {
    directories = [
      ".config/DankMaterialShell"
      ".local/state/DankMaterialShell"
    ];
  };
  home.file.".local/share/themes/Stylix/dms/theme.json".text = let
    colors = config.lib.stylix.colors.withHashtag;
  in
    builtins.toJSON {
      name = "Stylix DankMaterialShell Theme";
      primary = colors.base0B;
      primaryText = colors.base00;
      primaryContainer = colors.base0C;
      secondary = colors.base09;
      surface = colors.base01;
      surfaceText = colors.base05;
      surfaceVariant = colors.base01;
      surfaceVariantText = colors.base05;
      surfaceTint = colors.base0D;
      background = colors.base00;
      backgroundText = colors.base05;
      outline = colors.base04;
      surfaceContainer = colors.base03;
      surfaceContainerHigh = colors.base03;
      surfaceContainerHighest = colors.base04;
      error = colors.base08;
      warning = colors.base0A;
      info = colors.base05;
    };
}
