let
  region = "us-east-1";
  t2micro = "t2.micro";
in

{
  network.description = "Vdare network";
  network.enableRollback = true;

  # Provision an EC2 key pair.
  resources.ec2KeyPairs.appKeyPair = {
    inherit region;
  };

  backend =
    { config, pkgs, resources, ... }:
    {
      imports = [
        ./modules/common.nix
      ];

      deployment.targetEnv = "ec2";
      deployment.ec2.region = region;
      deployment.ec2.instanceType = t2micro;
      deployment.ec2.keyPair = resources.ec2KeyPairs.appKeyPair;

      networking.firewall.allowedTCPPorts = [
        80
      ];
    };
}
