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
        LaTeX = {
          language_servers = ["texpresso-lsp" "texlab"];
        };
      };

      lsp = {
        texlab.settings.texlab.build.onSave = false;
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
      # "mcp-server-github" waiting untill pat can be stored not in settings.json

      # Snippets
      "snippets"
      "python-snippets"

      # Utils
      "wakatime"
      "typos"
      "texpresso"
    ];
    extraPackages = with pkgs; [
      nixd
      nil
      alejandra
      texpresso
      pkgs.inputs.wakatime-ls.default
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
