{
  user,
  pkgs,
  ...
}:
let
  scale = 4. / 3.;
in
{
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

        inherit scale;
      };
    };

    # browser
    programs.librewolf.settings = {
      "layout.frame_rate" = 120;
    };
  };

  # virtual console
  services.kmscon.config.font-dpi = builtins.floor (96 * scale);

  # DDC/CI
  services.ddccontrol = {
    enable = true;
    package = pkgs.ddcutil-service;
  };

  users.users.${user}.extraGroups = [ "i2c" ];

  intransience.datastores.cache.users.${user}.dirs = [
    # monitor data
    ".cache/ddcutil"
  ];
}
