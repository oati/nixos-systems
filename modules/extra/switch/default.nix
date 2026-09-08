{ user, pkgs, ... }:
let
  package = pkgs.ryubing;
in
{
  home-manager.users.${user} = {
    home.packages = [ package ];
  };

  intransience.datastores.games.users.${user}.dirs = [
    ".config/Ryujinx"
  ];

  intransience.datastores.gamedata.users.${user}.dirs = [
    # save data
    ".config/Ryujinx/bis/user"
  ];

  intransience.datastores.cache.users.${user}.dirs = [
    ".cache/mesa_shader_cache"
  ];
}
