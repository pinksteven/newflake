{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;

    userSettings = {
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      vim_mode = true;
      load_direnv = "direct";

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
      # Language Servers
      "nix"
      "toml"
      "lua"
      "qml"
      "basher"
      "neocmake"

      # MCP servers
      "mcp-server-context7"
      # "mcp-server-github" waiting until pat can be stored not in settings.json

      # Snippets
      "snippets"
      "python-snippets"

      # Utils
      "wakatime"
      "typos"
    ];
    extraPackages = with pkgs; [
      nixd
      nil
      alejandra
    ];
  };

  home = {
    packages = with pkgs; [cloc];
    sessionVariables.EDITOR = "zeditor";
    persistence."/persist" = {
      files = [".wakatime.cfg"];
      directories = [
        ".config/zed"
        ".config/github-copilot"
        ".local/share/zed"
      ];
    };
  };
}
