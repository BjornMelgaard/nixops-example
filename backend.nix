{ region, instanceType, sharedNixStoreEfsDnsName }:
{ config, pkgs, resources, lib, ... }:

with lib;
with pkgs;

let
  backendApp = import ./backend-derivation.nix { inherit pkgs; };
in

{
  imports = [
    ./modules/common.nix
  ];

  deployment.targetEnv = "ec2";

  deployment.ec2 = {
    inherit region instanceType;
    keyPair = resources.ec2KeyPairs.appKeyPair;
    associatePublicIpAddress = true;
    ebsInitialRootDiskSize = 5;
    tags.Name = "Backend";
  };

  boot.supportedFilesystems = [ "nfs4" ];

  # TODO: not applied
  fileSystems."/nix/store" = {
    fsType = "nfs";
    device = "${sharedNixStoreEfsDnsName}:/";
    options = [ "nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2" ];
  };

  networking.firewall.allowedTCPPorts = [
    80
  ];

  systemd.services.startBackend = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" "docker.service" ];
    requires = [ "docker.service" ];

    environment = {
      BE_PORT = "80";
    };
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";

      User = "www";

      ExecStart = "${docker_compose}/bin/docker-compose -f ${backendApp}/docker-compose.prod.yml up -d --build";

      ExecStop = "${docker_compose}/bin/docker-compose -f ${backendApp}/docker-compose.prod.yml stop";
    };
  };
}
