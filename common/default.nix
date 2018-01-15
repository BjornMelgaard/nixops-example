{ pkgs, ... }:

with pkgs;

{
  services.openssh.passwordAuthentication = false;
  services.openssh.enable = true;
  services.cloud-init.enable = true;

  users = {
    mutableUsers = false;
    defaultUserShell = zsh;

    extraUsers.admin = {
      extraGroups = [ "wheel" "docker" ];
      isNormalUser = true;
    };

    extraGroups.admin = {};
  };

  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };

  environment = {
    systemPackages = [
      tmux
      neovim
      git
      ranger
      docker
      docker_compose
    ];

    variables = {
      EDITOR="nvim";
      TERM = "xterm-256color";
    };
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      ohMyZsh = {
        enable = true;
        theme = "lambda";
        plugins = [
          ## appearence
          "colorize"
          "compleat"
          "common-aliases"

          ## editing
          "vi-mode"

          ## navigation
          "history-substring-search"
          "dircycle"
          "dirpersist"

          "systemd"
          "sudo"

          "docker"
          "docker-compose"
        ];
      };
    };
    command-not-found.enable = true;
  };

  virtualisation.docker.enable = true;

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    22 # ssh, required
  ];
  networking.firewall.allowPing = true;
}
