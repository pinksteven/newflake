{lib, ...}: {
  imports = [./starship.nix];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    historySubstringSearch.enable = true;

    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets" "root"];
    };

    autosuggestion = {
      enable = true;
      strategy = ["history" "completion"];
    };

    initContent = lib.mkAfter ''
      bindkey -v


      bindkey -M viins " " abbr-expand-and-insert
      bindkey -M viins "^ " magic-space

      bindkey "^[[3~" delete-char
      microfetch
    '';

    history = {
      ignoreDups = true;
      save = 10000;
      size = 10000;
    };

    zsh-abbr = {
      enable = true;
      globalAbbreviations = {
        cd = "z";
        ls = "eza";
        tree = "eza --tree";
        g = "lazygit";

        nos = "nh os switch -a";
        nosu = "nh os switch -a -u --commit-lock-file";
        nocu = "nh os switch -n -u --no-update-lock-file";
        nor = "nh os rollback -a";
        ns = "nh search";
        nc = "nh clean all --keep 5";

        nl = "nix-locate";
        zed = "zeditor";

        tfg = "tailscale file get ~/Downloads";
      };
    };

    antidote = {
      enable = true;
      useFriendlyNames = true;
      plugins = [
        # "olets/zsh-autosuggestions-abbreviations-strategy"
        "zsh-users/zsh-completions"
        "ohmyzsh/ohmyzsh path:plugins/git"
        "chrissicool/zsh-256color"
      ];
    };
  };
  home.persistence."/persist/home/steven" = {
    directories = [".cache/antidote"];
    files = [".zsh_history"];
  };
}
