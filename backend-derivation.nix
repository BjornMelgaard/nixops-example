# test installation with `nix-build backend-app.nix`

{ pkgs ? (import <nixpkgs> {}), ... }:

with pkgs;

stdenv.mkDerivation {
  name = "backend";
  src = /backend-app;

  # use buildCommand instead of installPhase to omit `make`
  buildCommand = ''
    mkdir -p $out
    cp -r * $out/
  '';
}
