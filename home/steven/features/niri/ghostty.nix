{
  programs.ghostty = {
    enable = true;
  };
  programs.niri.settings.binds."Mod+grave".action.spawn = ["ghostty" "+new-window"];
}
