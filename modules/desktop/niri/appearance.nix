{user, ...}: {
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
          background-color = "#606060";

          gaps = 8;

          struts = let
            struts = -3;
          in {
            top = struts;
            bottom = struts;
            left = struts;
            right = struts;
          };

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
        };
      };
    };
  };
}
