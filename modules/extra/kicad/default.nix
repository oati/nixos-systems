{ user, pkgs, ... }:
let
  package = pkgs.kicad;
in
{
  home-manager.users.${user} = {
    home.packages = [ package ];
  };

  intransience.datastores.home.users.${user}.dirs = [
    # ".config/kicad"
    # ".local/share/kicad"
  ];
}
