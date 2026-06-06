{ user, pkgs, ... }:
let
  package = pkgs.prusa-slicer;
in
{
  home-manager.users.${user} = {
    home.packages = [ package ];
  };

  intransience.datastores.home.users.${user}.dirs = [
    ".config/PrusaSlicer"
    # ".local/share/prusa-slicer"
  ];
}
