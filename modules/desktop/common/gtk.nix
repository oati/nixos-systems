{
  user,
  pkgs,
  config,
  ...
}: {
  home-manager.users.${user} = {
    gtk = {
      enable = true;

      theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3-dark";
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = config.home-manager.users.${user}.gtk.theme.name;
        color-scheme = "prefer-dark";
      };
    };
  };
}
