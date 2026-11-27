{
  user,
  lib,
  pkgs,
  ...
}:
let
  package = pkgs.signal-desktop;
in
{
  imports = [
    ./packages
  ];

  home-manager.users.${user} = {
    home.packages = [ package ];

    # autostart
    systemd.user.services.signal-desktop = {
      Unit = {
        Description = "Signal Client";
        PartOf = [ "graphical-session.target" ];
        After = [
          "graphical-session.target"
          "dbus.service"
        ];
        Wants = [ "dbus.service" ];
      };
      Service = {
        ExecStartPre = "${lib.getExe' pkgs.glib "gdbus"} wait --session org.kde.StatusNotifierWatcher";
        ExecStart = "${lib.getExe package} --start-in-tray";
        Restart = "always";
        RestartSec = "5s";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };

  intransience.datastores.home.users.${user}.dirs = [
    ".config/Signal"
  ];
}
