{ user, pkgs, ... }:
let
  package = pkgs.musescore;
in
{
  home-manager.users.${user} = {
    home.packages = [ package ];
  };
}
