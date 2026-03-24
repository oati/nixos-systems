{lib, ...}: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      # needs force for iso-image
      timeout = lib.mkForce 8;
    };

    initrd.systemd.enable = true;
  };
}
