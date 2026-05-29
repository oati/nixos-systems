{
  user,
  pkgs,
  ...
}:
{
  home-manager.users.${user} = {
    home.packages = [ pkgs.geary ];
  };

  intransience.datastores.home.users.${user}.dirs = [
    ".config/geary"
    ".local/share/geary"
  ];
}
