{ user, ... }:
{
  hardware.opentabletdriver.enable = true;

  hardware.uinput.enable = true;
  boot.kernelModules = [ "uinput" ];

  intransience.datastores.home.users.${user}.dirs = [
    ".config/OpenTabletDriver"
  ];
}
