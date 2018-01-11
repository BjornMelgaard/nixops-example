FROM nixos/nix:latest

# - eval $(ssh-agent -s)
# - bash -c 'ssh-add <(echo "$DEPLOY_KEY")'
# - mkdir -p ~/.ssh
# - echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

# COPY . .
# RUN eval "$(ssh-agent -s)" && \
#     wget -i ./pre_sign_url -q -O - | openssl enc -aes-256-cbc -d -kfile passfile > ./my_key && \
#     chmod 700 ./my_key && \
#     ssh-add ./my_key && \
#     mkdir /root/.ssh && \
#     chmod 0700 /root/.ssh && \
#     ssh-keyscan github.com > /root/.ssh/known_hosts && \
#     [commands that require SSH access to Github] && \
#     rm ./my_key && \
#     rm ./passfile && \
#     rm -rf /root/.ssh/

# https://github.com/nardeas/docker-ssh-agent

# Pin packages to specific NixOS release
ENV NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs-channels/archive/nixos-17.09.tar.gz

RUN nix-channel --update
RUN nix-env -u '*'

RUN nix-env -i nixops git gnumake

####
ARG WORKDIR
RUN mkdir -p $WORKDIR
WORKDIR $WORKDIR

CMD /bin/sh
