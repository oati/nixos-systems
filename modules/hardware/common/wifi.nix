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

  # address race condition where iwd starts before the wifi card is initalized
  systemd.services.iwd.preStart = "${pkgs.coreutils}/bin/sleep 2";

  intransience.datastores.system.dirs = [
    "/var/lib/iwd"
  ];
}
