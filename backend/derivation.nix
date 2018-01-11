# mkDerivation code https://github.com/NixOS/nixpkgs/blob/master/pkgs/stdenv/generic/setup.sh
# test installation with `nix-build /app/backend/derivation.nix`

{ pkgs ? (import <nixpkgs> {}), ... }:

with pkgs;

# TODO: local -> fetchFromGit
stdenv.mkDerivation {
  name = "backend";

  # src = fetchgitLocal /backend;

  # src = fetchgit {
  #   url = file:///backend;
  #   rev = "89805d2a7cc0f254e8fcd95eb698482b2b724d35";
  #   sha256 = "0rn1fq8346k1nq6cy42iv1v4wdb84drg5g3n9784giir3amg1p1z";
  # };

  # src = fetchgitPrivate {
  # # src = fetchgit {
  #   url = "ssh://git@gitlab.nordicresults.com:446/ben/vd-rails.git";
  #   rev = "89805d2a7cc0f254e8fcd95eb698482b2b724d35";
  #   sha256 = "0rn1fq8346k1nq6cy42iv1v4wdb84drg5g3n9784giir3amg1p1z";
  # };

  src = /backend;

  # src = /app/common;

  # don't make
  dontBuild = true;

  # copy all files including hidden
  installPhase = ''
    mkdir -p $out
    cp -r * $out/
    cp -r .[^.]* $out/
  '';
}
