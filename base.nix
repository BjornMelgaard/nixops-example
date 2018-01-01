let
  region = "us-east-1";
  t2micro = "t2.micro";

  subnet = "subnet-14930963";
in

{
  network.description = "Vdare network";
  network.enableRollback = true;

  # Provision an EC2 key pair.
  resources.ec2KeyPairs.appKeyPair = {
    inherit region;
  };

  resources.elasticFileSystems.nixStore = {
    inherit region;
    size = 4;
    tags.Name = "Shareable nix store";
  };

  # resources.s3Buckets.backups = {
  #   inherit region;
  #   size = 3;
  # };

  resources.elasticFileSystemMountTargets.nixStoreMount =
    { resources, ... }:
    {
      inherit region subnet;
      fileSystem = resources.elasticFileSystems.nixStore;
    };

  backend = import ./backend.nix {
    inherit region subnet;
    instanceType = t2micro;
  };
}
