{pkgs, ...}: {
  imports = [
    ./zsh

    ./bat.nix
    ./bottom.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./nix-utils.nix
    ./ssh.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    microfetch # a really fast hardcoded nixos fetcher

    (octaveFull.withPackages
      (ps: with ps; [control]))
    ripgrep
    fd
    httpie
    jq
    playerctl

    # If i ever need to manually format nix from cmd
    alejandra
    nixfmt
  ];
}
