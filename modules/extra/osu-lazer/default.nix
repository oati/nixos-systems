{
  user,
  pkgs,
  ...
}: let
  package = pkgs.osu-lazer-bin;
in {
  home-manager.users.${user} = {
    home.packages = [package];
  };

  intransience.datastores.games.users.${user}.dirs = [
    ".local/share/osu"
  ];
}
