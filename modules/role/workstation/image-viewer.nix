{
  user,
  pkgs,
  ...
}:
let
  package = pkgs.image-roll;
in
{
  home-manager.users.${user} = {
    home.packages = [ package ];

    xdg.mimeApps.defaultApplicationPackages = [ package ];
  };
}
