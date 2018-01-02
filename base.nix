let
  region = "us-east-1";
  t2micro = "t2.micro";
  sharedNixStoreEfsDnsName = "fs-3efcfc77.efs.us-east-1.amazonaws.com";
in

{
  network.description = "Vdare network";
  network.enableRollback = true;

  # Provision an EC2 key pair.
  resources.ec2KeyPairs.appKeyPair = {
    inherit region;
  };

  backend = import ./backend.nix {
    inherit region sharedNixStoreEfsDnsName;
    instanceType = t2micro;
  };
}
