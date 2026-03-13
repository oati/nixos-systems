{...}: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 8;
    };

    initrd.systemd.enable = true;
  };
}
