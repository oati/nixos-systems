{user, ...}: {
  home-manager.users.${user} = {
    xdg.configFile."anytype/custom.css".text =
      # css
      ''
        body {
          font-family: "sans-serif", "monospace";
        }
      '';
  };
}
