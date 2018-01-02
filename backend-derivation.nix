# test installation with `nix-build backend-derivation.nix`

{ pkgs ? (import <nixpkgs> {}), ... }:

with pkgs;

# TODO: local -> fetchFromGit
stdenv.mkDerivation {
  name = "backend";
  src = /backend-app;

  # use buildCommand instead of installPhase to omit `make`
  buildCommand = ''
    mkdir -p $out
    cp -r * $out/
  '';
}
