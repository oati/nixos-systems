{
  user,
  lib,
  ...
}:
let
  # uuidgen | tr -d '-'
  machine-id = "049d0784b6c24a14943b0e8e100a3e8d";
in
{
  networking = {
    hostName = "erin-pc";
    hostId = lib.substring 0 8 machine-id;
  };

  environment.etc.machine-id.text = machine-id;

  time.timeZone = "America/Chicago";

  system.stateVersion = "26.05";
  home-manager.users.${user}.home.stateVersion = "26.05";
}
