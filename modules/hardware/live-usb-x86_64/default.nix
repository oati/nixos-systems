{...}: {
  imports = [
    ../common/utils.nix
  ];

  nixpkgs.hostPlatform = {
    system = "x86_64-linux";
  };

  hardware.enableRedistributableFirmware = true;
}
