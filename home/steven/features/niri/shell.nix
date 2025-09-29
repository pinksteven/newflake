{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
  ];
  programs.dankMaterialShell = {
    enable = true;
    enableSystemd = true;
    enableNightMode = false;
    enableDynamicTheming = false;
    quickshell.package = inputs.dankMaterialShell.packages.${pkgs.system}.quickshell;
    niri = {
      enableKeybinds = true;
    };
  };
}
