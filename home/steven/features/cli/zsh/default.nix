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
      bindkey -vd
      bindkey "^[[3~" delete-char
      pfetch
      tailscale completion zsh > "$\{fpath[1]}/_tailscale"
      ZSH_AUTOSUGGEST_STRATEGY=( abbreviations $ZSH_AUTOSUGGEST_STRATEGY )
    '';

    history = {
      ignoreDups = true;
      save = 10000;
      size = 10000;
    };

    zsh-abbr = {
      enable = true;
      abbreviations = {
        cd = "z";
        ls = "eza --icons=always --no-quotes";
        tree = "eza --icons=always --tree --no-quotes";
        g = "lazygit";

        nos = "nh os switch -a";
        nosu = "nh os switch -a -u --commit-lock-file";
        nocu = "nh os switch -n -u --no-update-lock-file";
        nor = "nh os rollback -a";
        ns = "nh search";
        nc = "nh clean all --keep 5";

        nl = "nix-locate";
      };
    };

    antidote = {
      enable = true;
      useFriendlyNames = true;
      plugins = [
        "olets/zsh-autosuggestions-abbreviations-strategy"
        "zsh-users/zsh-completions"
        "zsh-users/zsh-autocorrect"
        "ohmyzsh/ohmyzsh path:plugins/git"
        "chrissicool/zsh-256color"
      ];
    };
  };
  home.persistence."/persist".files = [".zsh_history"];
}
