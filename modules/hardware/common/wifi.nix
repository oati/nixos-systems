{pkgs, ...}: {
  networking = {
    wireless.iwd = {
      enable = true;

      settings = {
        General = {
          AddressRandomization = "network";
        };
        Scan = {
          # default 10
          InitialPeriodicScanInterval = 5;
          # default 300
          MaximumPeriodicScanInterval = 300;
        };
      };
    };

    networkmanager.wifi.backend = "iwd";
  };

  intransience.datastores.system.dirs = [
    "/var/lib/iwd"
  ];
}
