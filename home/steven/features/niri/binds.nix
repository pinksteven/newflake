{config, ...}: {
  programs.niri.settings.binds = with config.lib.niri.actions;
    {
      "Ctrl+Alt+Delete".action = quit;
      "Mod+F".action = spawn-sh "yazi";
      "Mod+B".action = spawn "firefox";
      "Mod+Q".action = close-window;
    }
    // builtins.listToAttrs (builtins.genList (i: {
        name = "Mod+${toString i}";
        value.action = focus-workspace (
          if i == 0
          then 10
          else i
        );
      })
      10);
}
