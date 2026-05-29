{
  user,
  pkgs,
  ...
}:
{
  home-manager.users.${user} = {
    programs.gpg.enable = true;

    services.gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-gnome3;

      defaultCacheTtl = 1200; # 20 minutes
      maxCacheTtl = 7200; # 2 hours
    };

    # needed for pinentry-gnome3
    home.packages = [ pkgs.gcr ];
  };

  intransience.datastores.home.users.${user}.dirs = [
    {
      path = ".gnupg";
      mode = "0700";
    }
  ];
}
