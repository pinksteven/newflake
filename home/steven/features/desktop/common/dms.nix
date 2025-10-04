{
  inputs,
  pkgs,
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
    enableNightMode = false;
    enableDynamicTheming = false;
    quickshell.package = inputs.dankMaterialShell.packages.${pkgs.system}.quickshell;
  };
  home.persistence."/persist/home/steven" = {
    directories = [
      ".config/DankMaterialShell"
      ".local/state/DankMaterialShell"
    ];
  };
}
