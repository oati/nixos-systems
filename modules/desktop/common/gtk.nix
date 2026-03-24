{
  user,
  pkgs,
  ...
}: {
  home-manager.users.${user} = {config, ...}: {
    gtk = {
      enable = true;

      theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3-dark";
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = config.gtk.theme.name;
        color-scheme = "prefer-dark";
      };
    };
  };
}
