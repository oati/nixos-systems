# hardware utilities
{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.usbutils
    pkgs.pciutils

    # SMBIOS data
    pkgs.dmidecode

    # sensor info
    pkgs.lm_sensors
  ];
}
