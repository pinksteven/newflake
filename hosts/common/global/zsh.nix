{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    syntaxHighlighting = {
      enable = true;
    };
    autosuggestions = {
      enable = true;
    };
  };

  # For system packages completion
  environment.pathsToLink = ["/share/zsh"];
}
