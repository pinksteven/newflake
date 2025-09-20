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
    ./pfetch.nix
    ./ssh.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    comma # don't care about nix shell and shit just run

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
