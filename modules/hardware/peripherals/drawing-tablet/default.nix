{ user, ... }:
{
  hardware.opentabletdriver.enable = true;

  hardware.uinput.enable = true;

  intransience.datastores.home.users.${user}.dirs = [
    ".config/OpenTabletDriver"
  ];
}
