{
  programs.yazi.settings.yazi.prepend_fetchers = [
    {
      id = "git";
      name = "*";
      run = "git";
    }
    {
      id = "git";
      name = "*/";
      run = "git";
    }
  ];
}
