{pkgs, ...}: {
  imports = [
    ./keymap.nix
    ./fetchers.nix
    ./open.nix
    ./previewers.nix
  ];

  programs.yazi = {
    enable = true;
    # package = pkgs.yazi.override {
    #   _7zz = pkgs._7zz.override {enableUnfree = true;};
    # };
    enableZshIntegration = true;
    shellWrapperName = "y";

    settings = {
      mgr = {
        ratio = [
          2
          5
          3
        ];

        sort_by = "natural";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        sort_translit = true;

        linemode = "none";
        show_hidden = false;
        show_symlink = true;
        scrolloff = 5;
        title_format = "Yazi - {cwd}";
      };
      preview = {
        wrap = "yes";
        tab_size = 2;

        max_width = 1000;
        max_height = 1000;
        image_filter = "triangle";
        image_quality = 70;
      };
    };

    plugins = {
      chmod = pkgs.yaziPlugins.chmod;
      full-border = pkgs.yaziPlugins.full-border;
      toggle-pane = pkgs.yaziPlugins.toggle-pane;
      mount = pkgs.yaziPlugins.mount;
      git = pkgs.yaziPlugins.git;
      lazygit = pkgs.yaziPlugins.lazygit;
      vcs-files = pkgs.yaziPlugins.vcs-files;
      starship = pkgs.yaziPlugins.starship;
      piper = pkgs.yaziPlugins.piper;
      wl-clipboard = pkgs.yaziPlugins.wl-clipboard;
      recycle-bin = pkgs.yaziPlugins.recycle-bin;
      compress = pkgs.yaziPlugins.compress;
    };

    initLua = ''
      require("full-border"):setup()
      require("git"):setup()
      require("starship"):setup()
      require("recycle-bin"):setup()

      if os.getenv("NVIM") then
      	require("toggle-pane"):entry("min-preview")
      end
    '';
  };

  home.packages = with pkgs; [
    dragon-drop
    wl-clipboard
    glow
    rich-cli
    trash-cli
    # Want this in path as well
    _7zz
  ];
}
