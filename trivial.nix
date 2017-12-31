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

  backend =
    { config, pkgs, ... }:
    { services.httpd.enable = true;
      services.httpd.adminAddr = "alice@example.org";
      services.httpd.documentRoot = "${pkgs.valgrind.doc}/share/doc/valgrind/html";
      networking.firewall.allowedTCPPorts = [ 80 ];

      inherit users;
    };

in

{
  network.description = "Load balancing network";

  inherit backend;
}
