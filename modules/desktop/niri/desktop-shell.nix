{
  user,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.${user} = {config, ...}: {
    xdg.configFile."delta-shell/config.json".text = builtins.toJSON {
      # animation time in seconds
      transition = 0.1;
      bar = {
        size = 20;
        position = "top";

        modules = {
          start = ["clipboard"];
          center = ["clock"];
          end = ["recordindicator" "tray" "weather" "cpu" "ram" "battery" "notificationslist" "quicksettings"];

          clock.format = "%b %d %H:%M";
          tray.compact = false;
          cpu.format = "{icon} {usage}%";
          ram.format = "{icon} {usage}%";
          battery.format = "{icon} {percent}%";
        };
      };

      clipboard = {
        width = 360;
        height = 480;
        max-items = 50;
      };

      notifications = {
        width = 360;
        list.height = 600;
        position = "top-right";
        timeout = 5;
      };

      weather = {
        location.auto = true;
      };

      quicksettings = {
        buttons = ["network" "bluetooth" "power" "screenrecord"];
        sliders = ["volume" "microphone" "brightness"];
      };

      osd = {
        # https://github.com/Sinomor/delta-shell/issues/25
        enabled = false;
        width = 320;
        height = 24;
        position = "top-right";
        timeout = 1;
      };
    };

    xdg.configFile."delta-shell/theme.json".text = builtins.toJSON {
      font = {
        name = "sans-serif";
        size = config.stylix.fonts.sizes.desktop;
      };

      icon-size = {
        small = 16;
        normal = 18;
        large = 24;
      };

      spacing = 10;

      radius = 8;

      colors.accent = "#BF5700";

      shadow = false;
    };

    systemd.user.services.delta-shell = {
      Unit = {
        Description = "Delta Shell";
        PartOf = ["graphical-session.target"];
        After = [
          "graphical-session.target"
          "dbus.service"
        ];
        Wants = ["dbus.service"];
        X-Restart-Triggers = [
          config.xdg.configFile."delta-shell/config.json".source
          config.xdg.configFile."delta-shell/theme.json".source
        ];
      };
      Service = {
        ExecStartPre = "${pkgs.coreutils}/bin/sleep 1";
        ExecStart = "${lib.getExe pkgs.delta-shell} run";
        Restart = "always";
        RestartSec = 1;
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
