{user, ...}: {
  home-manager.users.${user} = {
    qt = {
      enable = true;
      platformTheme.name = "gtk3";
      style.name = "adwaita-dark";
    };
  };
}
