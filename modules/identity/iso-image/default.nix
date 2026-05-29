{
  user,
  lib,
  ...
}:
let
  # uuidgen | tr -d '-'
  machine-id = "45e552cb2a7f4aefaab49a8fe0d44d34";
in
{
  networking = {
    hostName = "nixos-iso";
    hostId = lib.substring 0 8 machine-id;
  };

  environment.etc.machine-id.text = machine-id;

  time.timeZone = "Etc/UTC";

  system.stateVersion = lib.trivial.release;
  home-manager.users.${user}.home.stateVersion = lib.trivial.release;
}
