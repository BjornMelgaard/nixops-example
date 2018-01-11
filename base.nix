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

  backend = import ./backend {
    inherit region;
    instanceType = t2micro;
  };
}
