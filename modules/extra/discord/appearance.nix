{
  flakes,
  user,
  ...
}: {
  home-manager.users.${user} = {
    programs.vesktop.vencord = {
      settings.enabledThemes = [
        "system-fonts.css"
        "smaller-sidebar.css"
        "amoled-cord.css"
      ];

      themes = {
        system-fonts =
          # css
          ''
            :root {
              --font-primary: "sans-serif";
              --font-display: "sans-serif";
              --font-code: "monospace";
            }
          '';

        # shrink sidebar from 240px if width is less than 2/3 of 1920px screen width
        smaller-sidebar =
          # css
          ''
            @media (max-width: 1280) {
              div [class *= "sidebarList__"] {
                width: 210px !important;
              }
            }
          '';

        amoled-cord = "${flakes.amoled-cord}/clients/amoled-cord.theme.css";
      };
    };
  };
}
