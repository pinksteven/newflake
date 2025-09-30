{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;

    userSettings = {
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      vim_mode = true;

      languages = {
        Nix.formatter.external = {
          command = "alejandra";
          arguments = ["--quiet" "--"];
        };
      };
    };
    # userTasks = {};
    # userKeymaps = {};

    extensions = [
      "nix"
      "toml"
      "lua"
      "neocmake"
      "basher"
      "wakatime"
      "qml"
      "snippets"
      "colored-zed-icons-theme"
    ];
    extraPackages = with pkgs; [
      nixd
      nil
      alejandra
      pkgs.inputs.wakatime-ls.default
    ];
  };

  home = {
    packages = with pkgs; [cloc];
    sessionVariables.EDITOR = "zeditor";
    persistence."/persist/home/steven" = {
      directories = [
        ".config/zed"
        ".local/share/zed"
      ];
      files = [".wakatime.cfg"];
    };
  };
}
