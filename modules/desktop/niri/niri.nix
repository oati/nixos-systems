{
  user,
  lib,
  ...
}: {
  home-manager.users.${user} = {
    programs.niri = {
      settings = {
        screenshot-path = "~/screenshots/screenshot_%Y-%m-%d_%H-%M-%S.png";

        clipboard.disable-primary = true;

        input.mouse = {
          accel-profile = "flat";
          accel-speed = 0.25;
        };

        cursor = {
          hide-after-inactive-ms = null;
          hide-when-typing = false;
          size = 24;
          theme = "default";
        };

        window-rules = [
          {
            geometry-corner-radius = let
              radius = 15.;
            in {
              bottom-left = radius;
              bottom-right = radius;
              top-left = radius;
              top-right = radius;
            };
            clip-to-geometry = true;
          }
        ];

        layout = {
          empty-workspace-above-first = true;

          background-color = "#606060";

          gaps = 8;

          focus-ring = {
            width = 3;
            active.color = "#7FC8FF";
            inactive.color = "#505050";
            # urgent
          };

          tab-indicator = {
            width = 4;
            gap = 5;
            place-within-column = true;
            active.color = "#7FC8FF";
            inactive.color = "#505050";
          };

          preset-window-heights = [
            {proportion = 1. / 3.;}
            {proportion = 1. / 2.;}
            {proportion = 2. / 3.;}
          ];

          default-column-width = {proportion = 1. / 2.;};
        };

        environment = {
          QT_QPA_PLATFORM = "wayland";
        };
      };
    };

    # workaround to add custom configs
    xdg.configFile."niri/config.kdl".text =
      # kdl
      ''
        include "generated-config.kdl"

        // disable recent windows keybinds
        recent-windows {
          off
        }
      '';

    xdg.configFile.niri-config.target = lib.mkForce "niri/generated-config.kdl";
  };
}
