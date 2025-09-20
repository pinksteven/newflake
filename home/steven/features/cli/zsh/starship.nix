{
  config,
  lib,
  ...
}: let
  accent =
    if config.stylix.enable
    then config.lib.stylix.colors.withHashtag.base0D
    else "green";
  background-alt =
    if config.stylix.enable
    then config.lib.stylix.colors.withHashtag.base01
    else "black";
in {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$character"
      ];
      directory = {
        style = accent;
      };

      character = {
        success_symbol = "[❯](${accent})";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](cyan)";
      };

      git_branch = {
        symbol = "[](${accent}) ";
        style = "fg:${background-alt} bg:${accent}";
        format = "on [$symbol$branch]($style)[](${accent}) ";
      };

      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218)($ahead_behind$stashed)]($style)";
        style = "cyan";
        conflicted = "";
        renamed = "";
        deleted = "";
        stashed = "≡";
      };

      git_state = {
        format = "([$state( $progress_current/$progress_total)]($style)) ";
        style = "bright-black";
      };
    };
  };
}
