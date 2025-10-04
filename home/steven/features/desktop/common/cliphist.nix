{
  lib,
  pkgs,
  ...
}: let
  clipboard = pkgs.writeShellScriptBin "clipboard" ''
    cliphist list | ${lib.getExe pkgs.anyrun} --plugins ${pkgs.anyrun}/lib/libstdin.so --show_results_immediately true | cliphist decode | wl-copy
  '';
in {
  services.cliphist = {
    enable = true;
    systemdTargets = "graphical-session.target";
  };
  home.packages = [clipboard];
}
