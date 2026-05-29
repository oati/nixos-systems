{ ... }:
{
  hardware.bluetooth.enable = true;

  intransience.datastores.system.dirs = [
    "/var/lib/bluetooth"
  ];
}
