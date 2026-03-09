{...}: {
  networking = {
    networkmanager = {
      enable = true;
    };
  };

  services = {
    avahi = {
      enable = true;
    };
  };

  environment.etc = {
    "NetworkManager/system-connections" = {
      source = "/var/opt/NetworkManager/system-connections";
      mode = "symlink";
    };

    avahi = {
      source = "/var/opt/avahi";
      mode = "symlink";
    };
  };

  systemd = {
    tmpfiles.settings."91-var-opt" = {
      "/var/opt/NetworkManager/system-connections".d = {
        user = "root";
        group = "root";
        mode = "0700";
      };

      "/var/opt/avahi".d = {
        user = "root";
        group = "root";
        mode = "0755";
      };
    };

    # reduce startup delay
    services.NetworkManager-wait-online.enable = false;
    network.wait-online.enable = false;
  };

  # TODO: vpn, dns filter

  intransience.datastores.system.dirs = [
    "/var/lib/NetworkManager"
  ];
}
