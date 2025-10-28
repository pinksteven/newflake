{pkgs, ...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    package = pkgs.gitAndTools.gitFull;

    settings = {
      user = {
        name = "PinkSteven";
        email = "st.latuszek@gmail.com";
      };
      init.defaultBranch = "main";
      push.default = "current";
      push.autoSetupRemote = true;

      merge.conflictStyle = "zdiff3";
      merge.tool = "nvimdiff";
      commit.verbose = true;
      diff.algorithm = "histogram";
      branch.sort = "committerdate";

      rerere.enabled = true;

      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        cm = "commit -m";
        amend = "commit --amend";
        lg = "log --oneline --graph --all --decorate";
        lgg = "log --oneline --graph --decorate --all --stat";
        df = "diff";
        dc = "diff --cached";
        last = "log -1 HEAD";
        unstage = "reset HEAD --";
        aliases = "!git config -l | grep allowDiscards";
      };
    };
    ignores = [
      ".direnv"
    ];
  };
  programs.lazygit.enable = true;
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
