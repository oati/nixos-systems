{
  user,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./packages
  ];

  hardware.amdgpu.opencl.enable = true;

  home-manager.users.${user} = {
    home.packages = with pkgs; [
      nibbler
      lc0
    ];

    xdg.configFile."Nibbler/engines.json".text = builtins.toJSON {
      ${builtins.unsafeDiscardStringContext (lib.getExe pkgs.lc0)} = {
        args = [];
        options = {
          # https://lczero.org/dev/wiki/networks/
          WeightsFile = pkgs.fetchurl {
            url = "https://storage.lczero.org/files/networks-contrib/big-transformers/BT4-1740.pb.gz";
            hash = "sha256-SpfZHJHnun0nuxLP1tOZdaeBk3I5ZHmGlDHLtHmpf8s=";
          };
        };
        search_nodes = null;
        search_nodes_special = 10000;
        limit_by_time = false;
      };
    };
  };
}
