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
        on = ["c" "m"];
        run = "plugin chmod";
        desc = "Chmod files";
      }
      {
        on = ["g" "g"];
        run = "plugin lazygit";
        desc = "lazygit";
      }
      {
        on = ["g" "c"];
        run = "plugin vcs-files";
        desc = "Show Git file changes";
      }
      {
        on = "M";
        run = "plugin mount";
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
        on = ["c" "a" "a"];
        run = "plugin compress";
        desc = "Archive selected files";
      }
      {
        on = ["c" "a" "p"];
        run = "plugin compress -ph";
        desc = "Archive selected files (password)";
      }
      {
        on = ["c" "a" "l"];
        run = "plugin compress -l";
        desc = "Archive selected files (compression level)";
      }
      {
        on = ["c" "a" "u"];
        run = "plugin compress -phl";
        desc = "Archive selected files (password+level)";
      }
    ];
  };
}
