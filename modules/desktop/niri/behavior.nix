{user, ...}: {
  home-manager.users.${user} = {
    programs.niri = {
      settings = {
        screenshot-path = "~/screenshots/screenshot_%Y-%m-%d_%H-%M-%S.png";

        clipboard.disable-primary = true;

        layout = {
          empty-workspace-above-first = true;

          preset-column-widths = [
            {proportion = 1. / 3.;}
            {proportion = 1. / 2.;}
            {proportion = 2. / 3.;}
          ];

          preset-window-heights = [
            {proportion = 1. / 3.;}
            {proportion = 1. / 2.;}
            {proportion = 2. / 3.;}
          ];

          default-column-width = {proportion = 1. / 2.;};
        };
      };
    };
  };
}
