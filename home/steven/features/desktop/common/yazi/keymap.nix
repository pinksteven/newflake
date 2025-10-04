{
  programs.yazi.keymap = {
    mgr.prepend_keymap = [
      {
        on = "<C-q>";
        run = "quit";
        desc = "Quit Yazi";
      }
      {
        on = "<C-x>";
        run = "close";
        desc = "Close tab";
      }
      {
        on = "<C-n>";
        run = ''shell 'dragon-drop -x -i -a -T "$1"' --confirm'';
        desc = "Drag and drop selected files";
      }
      {
        on = [
          "c"
          "m"
        ];
        run = "plugin chmod";
        desc = "Chmod files";
      }
      {
        on = [
          "g"
          "g"
        ];
        run = "plugin lazygit";
        desc = "lazygit";
      }
      {
        on = "<C-c>";
        run = "plugin wl-clipboard";
        desc = "Copy to clipboard";
      }
      {
        on = "<C-y>";
        run = "plugin wl-clipboard";
        desc = "Copy to clipboard";
      }
      {
        on = "<Enter>";
        run = "plugin smart-enter";
      }
    ];
  };
}
