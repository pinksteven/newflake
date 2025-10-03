{config, ...}: {
  programs.kitty = {
    enable = true;
    settings = {
      scrollback_lines = 10000;
      initial_window_width = 1200;
      initial_window_height = 600;
      update_check_interval = 0;
      enable_audio_bell = false;
      confirm_os_window_close = "0";
      remember_window_size = "no";
      disable_ligatures = "never";
      url_style = "curly";
      cursor_shape = "Underline";
      cursor_underline_thickness = 3;
      window_padding_width = 10;

      background_blur = 64;
      transparent_background_colors = with config.lib.stylix.colors.withHashtag; "${base01} ${base02} ${base03}";

      "modify_font underline_position" = 2;
      "modify_font underline_thickness" = "150%";
    };
  };

  home.file.".config/xfce4/helpers.rc".text = ''
    TerminalEmulator=kitty
  '';
}
