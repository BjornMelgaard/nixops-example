{ region, instanceType }:
{ config, pkgs, resources, lib, ... }:

with (import ../lib/keys.nix);

with lib;
with pkgs;

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
    ebsInitialRootDiskSize = 100;
    tags.Name = "Vdare nixops backend";
    securityGroups = [ "vdare-nixops" ];
  };

  networking.firewall.allowedTCPPorts = [
    80
  ];

  swapDevices = singleton
  {
    device = "/var/swap";
    size = 2048;

    # device = "/var/swapfile";
    # label = "swapfile";
    # size = 2048;
  };
}
