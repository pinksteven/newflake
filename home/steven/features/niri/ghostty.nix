{
  programs.ghostty = {
    enable = true;
  };
  programs.niri.settings.binds."Mod+T".action.spawn = ["ghostty" "+new-window"];
}
