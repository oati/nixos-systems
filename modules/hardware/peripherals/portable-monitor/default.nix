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

  # niri output
  home-manager.users.${user} = {
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
  };
}
