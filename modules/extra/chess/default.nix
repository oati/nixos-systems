{
  user,
  lib,
  pkgs,
  ...
}:
{
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
        args = [ ];
        options = {
          # https://lczero.org/dev/wiki/networks/
          WeightsFile = pkgs.fetchurl {
            url = "https://storage.lczero.org/files/networks-contrib/BT4-1024x15x32h-swa-6147500-policytune-332.pb.gz";
            hash = "sha256-5q2p1sSnab+rOqCEjYLK64CapF+D5sYF/FijHSG91hg=";
          };
        };
        backend = "onnx-rocm";
        search_nodes = null;
        search_nodes_special = 10000;
        limit_by_time = false;
      };
    };
  };

  intransience.datastores.cache.users.${user}.dirs = [
    ".cache/lc0"
  ];
}
