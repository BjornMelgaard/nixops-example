{ pkgs, ... }:

with pkgs;
with (import ../shared/keys.nix);

{
  services.openssh.passwordAuthentication = false;
  services.openssh.enable = true;

  users = {
    mutableUsers = false;
    defaultUserShell = zsh;

    extraUsers.root.openssh.authorizedKeys.keys = devOpsKeys;

    extraUsers.www = {
      extraGroups = [ "wheel" ];
      isNormalUser = true;
      openssh.authorizedKeys.keys = devKeys;
    };

    extraGroups.www = {};
  };

  environment = {
    systemPackages = [
      tmux
      neovim
      docker
      git
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
