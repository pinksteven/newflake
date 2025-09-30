{pkgs, ...}: {
  imports = [
    ./zsh

    ./bat.nix
    ./bottom.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./nix-index.nix
    ./ssh.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    microfetch # a really fast hardcoded nixos fetcher

    octaveFull # Big boy calc for all my needs
    ripgrep
    fd
    httpie
    jq

    # If i ever need to manually format nix from cmd
    alejandra
    nixfmt-rfc-style
  ];
}
