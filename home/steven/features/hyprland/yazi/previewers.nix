{
  programs.yazi.settings.plugin.prepend_previewers = [
    {
      name = "*/";
      run = ''
        piper -- eza -TL=2 --color=always --icons=always \
              --group-directories-first --no-quotes "$1" \
              | tail -n +2 \
              | perl -pe 's/(\x1b\[1;90m)(.*?)(?=\s(?=\S)|\x1b\[0m)/$1/' '';
    }
    {
      name = "*.md";
      run = ''piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark "$1"'';
    }
  ];
}
