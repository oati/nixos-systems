{
  user,
  pkgs,
  ...
}:
let
  package = pkgs.iloader;
in
{
  home-manager.users.${user} = {
    home.packages = [ package ];
  };

  services.usbmuxd.enable = true;

  users.users.${user}.extraGroups = [ "usbmux" ];

  intransience.datastores.home.users.${user}.dirs = [
    ".local/share/me.nabdev.iloader"
  ];
}
