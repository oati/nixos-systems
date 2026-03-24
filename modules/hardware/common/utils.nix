# hardware utilities
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    usbutils
    pciutils

    # SMBIOS data
    dmidecode

    # sensor info
    lm_sensors
  ];
}
