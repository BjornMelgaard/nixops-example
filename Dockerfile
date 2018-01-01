FROM nixos/nix:latest

# Pinning a specific NixOS release
# ENV NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs-channels/archive/nixos-15.09.tar.gz:.

RUN nix-channel --update
RUN nix-env -u '*'

RUN nix-env -i nixops git

## CREATE APP USER ##
ENV USER=www-data
ENV GROUP=$USER

RUN set -x ; \
  addgroup -g 82 -S $GROUP ; \
  adduser -u 82 -D -S -G $GROUP -G wheel $USER

## SETTING UP THE APP ##
ARG APP_DIR

RUN mkdir -p $APP_DIR

RUN chown -R $USER:$GROUP $APP_DIR

VOLUME $APP_DIR

##
# USER $USER
ENV NIXOPS_STATE=$APP_DIR/localstate.nixops

# add secrets
COPY .env /tmp/.env
RUN export $(cat /tmp/.env | xargs)

USER $USER
WORKDIR $APP_DIR

CMD /bin/sh
