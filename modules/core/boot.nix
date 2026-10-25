{ lib, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      # needs force for iso-image
      timeout = lib.mkForce 8;
    };

    # remove when stateVersion >= 26.11
    zfs.forceImportRoot = false;
  };
}
