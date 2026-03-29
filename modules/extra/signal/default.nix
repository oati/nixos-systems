{
  user,
  lib,
  pkgs,
  ...
}: let
  signal-desktop = pkgs.signal-desktop;
in {
  home-manager.users.${user} = {
    home.packages = [
      signal-desktop
    ];

    # autostart
    systemd.user.services.signal-desktop = {
      Unit = {
        Description = "Signal Client";
        PartOf = ["graphical-session.target"];
        After = [
          "graphical-session.target"
          "dbus.service"
        ];
        Wants = ["dbus.service"];
      };
      Service = {
        ExecStartPre = "${pkgs.coreutils}/bin/sleep 5";
        ExecStart = "${lib.getExe signal-desktop} --start-in-tray";
        Restart = "always";
        RestartSec = "5s";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };

  intransience.datastores.home.users.${user}.dirs = [
    ".config/Signal"
  ];
}
