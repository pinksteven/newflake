{inputs, pkgs, ...}: {
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
  ];
  programs.dankMaterialShell = {
    enable = true;
    enableSystemd = true;
    enableNightMode = false;
    enableDynamicTheming = false;
    quickshell.package = pkgs.quickshell;
    niri = {
      enableKeybinds = true;
    };
  };
}
