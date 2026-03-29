{
  user,
  pkgs,
  ...
}: {
  # DDC/CI
  services.ddccontrol = {
    enable = true;
    package = pkgs.ddcutil-service;
  };

  users.users.${user}.extraGroups = ["i2c"];

  home-manager.users.${user} = {
    # niri output
    programs.niri.settings.outputs = {
      "PNP(YMK) EM160TP-A 0x00000001" = {
        focus-at-startup = true;
        mode = {
          width = 2880;
          height = 1800;
          refresh = 120.001;
        };
      };
    };

    # browser
    programs.librewolf.settings = {
      "layout.frame_rate" = 120;
    };
  };

  intransience.datastores.cache.users.${user}.dirs = [
    # monitor data
    ".cache/ddcutil"
  ];
}
