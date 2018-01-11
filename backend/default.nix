{ region, instanceType }:
{ config, pkgs, resources, lib, ... }:

with (import ../lib/keys.nix);

with lib;
with pkgs;

let
  environment = import ./env.nix;
  backendApp = import ./derivation.nix { inherit pkgs; };
in
{
  imports = [
    ../common
  ];

  users.extraUsers.root.openssh.authorizedKeys.keys = devKeys;
  users.extraUsers.admin.openssh.authorizedKeys.keys = devKeys;

  deployment.targetEnv = "ec2";

  deployment.ec2 = {
    inherit region instanceType;
    keyPair = resources.ec2KeyPairs.appKeyPair;
    associatePublicIpAddress = true;
    ebsInitialRootDiskSize = 10;
    tags.Name = "Backend";
  };

  networking.firewall.allowedTCPPorts = [
    80
  ];

  systemd.services.startBackend = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" "docker.service" ];
    requires = [ "docker.service" ];

    inherit environment;
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";

      User = "www";

      ExecStart = "${docker_compose}/bin/docker-compose -f ${backendApp}/docker-compose.prod.yml up -d --build";

      ExecStop = "${docker_compose}/bin/docker-compose -f ${backendApp}/docker-compose.prod.yml stop";
    };
  };
}
