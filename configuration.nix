let

  users = {
    mutableUsers = false;
    extraUsers =
      let hashedPassword = "$6$PHzWXNO5$1ZdGosjIXfQMxC82l/xncnuNF5IF3yT8.z9jPtqSzzVQjJk1NrwJsJuwKHEeBpau0xujxSPkQmgIep/EdzJGV/";
      in {
        root = {
          inherit hashedPassword;
        };
        deploy = {
          isNormalUser = true;
          extraGroups = [ "audio" "disk" "wheel" ];
          inherit hashedPassword;
        };
      };
  };

in

{
  inherit users;
}
