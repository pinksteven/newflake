{pkgs ? import <nixpkgs> {}, ...}: rec {
  dungeondraft = pkgs.callPackage ./dungeondraft {};
  loreforge = pkgs.callPackage ./loreforge {};
}
