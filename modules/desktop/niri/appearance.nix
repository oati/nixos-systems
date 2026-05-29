{ user, ... }:
{
  home-manager.users.${user} = {
    programs.niri = {
      settings = {
        cursor = {
          hide-after-inactive-ms = null;
          hide-when-typing = false;
          size = 24;
          theme = "default";
        };

        window-rules = [
          {
            geometry-corner-radius =
              let
                radius = 15.;
              in
              {
                bottom-left = radius;
                bottom-right = radius;
                top-left = radius;
                top-right = radius;
              };
            clip-to-geometry = true;
          }
        ];

        layout = {
          background-color = "#101010";

          gaps = 8;

          struts =
            let
              verticalStruts = -4;
              horizontalStruts = -2;
            in
            {
              top = verticalStruts;
              bottom = verticalStruts;
              left = horizontalStruts;
              right = horizontalStruts;
            };

          focus-ring.enable = false;

          tab-indicator = {
            width = 4;
            gap = 2;
            active.color = "#BF5700";
            inactive.color = "#505050";
          };
        };
      };
    };
  };
}
