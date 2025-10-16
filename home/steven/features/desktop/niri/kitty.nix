{
  programs = {
    kitty = {
      enable = true;
      enableGitIntegration = true;

      settings = {
        confirm_os_window_close = "0";
      };
    };

    zsh.initContent = ''
      if test -n "$KITTY_SHELL_INTEGRATION"; then
          autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
          kitty-integration
          unfunction kitty-integration
      fi
    '';
    niri.settings.binds."Mod+grave".action.spawn = ["kitty"];
  };
}
