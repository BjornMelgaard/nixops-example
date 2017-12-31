let
  region = "us-east-1";

  # prophile name, created on iam console, and added to ~/.ec2-keys in form "access secret name"
  # all you need to do is make this non-root prophile and deploy
  # XXX: to remove instance use `nixops destroy`, not `delete`
  accessKeyId = "nixops-test";

  ec2 =
    { resources, ... }:
    {
      deployment.targetEnv = "ec2";

      deployment.ec2.accessKeyId = accessKeyId;

      deployment.ec2.region = region;
      deployment.ec2.instanceType = "t2.micro";

      deployment.ec2.keyPair = resources.ec2KeyPairs.appKeyPair;

      deployment.ec2.securityGroups = [ "allow-ssh" "allow-http" ];
    };

in

{
  backend = ec2;

  # Provision an EC2 key pair.
  resources.ec2KeyPairs.appKeyPair =
    { inherit region accessKeyId; };
}

