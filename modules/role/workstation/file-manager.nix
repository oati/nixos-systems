{
  user,
  pkgs,
  ...
}:
let
  package = pkgs.nautilus;
in
{
  home-manager.users.${user} = {
    home.packages = [ package ];

    xdg.mimeApps.defaultApplicationPackages = [ package ];
  };
}
