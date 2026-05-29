{
  flakes,
  user,
  ...
}:
{
  home-manager.users.${user} = {
    programs.vesktop.vencord = {
      settings.enabledThemes = [
        "system-fonts.css"
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

        amoled-cord = "${flakes.amoled-cord}/clients/amoled-cord.theme.css";
      };
    };
  };
}
