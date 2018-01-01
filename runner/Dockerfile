FROM nixos/nix:latest

# Pinning a specific NixOS release
# ENV NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs-channels/archive/nixos-15.09.tar.gz:.

RUN nix-channel --update
RUN nix-env -u '*'

RUN nix-env -i nixops git gnumake

#
ARG WORKDIR
RUN mkdir -p $WORKDIR
WORKDIR $WORKDIR

CMD /bin/sh
