{ flakes, ... }:
{
  imports = [
    # battery power management
    flakes.nixos-hardware.nixosModules.common-pc-laptop

    # ssd trim
    flakes.nixos-hardware.nixosModules.common-pc-ssd

    # AMD mainboard
    "${flakes.nixos-hardware}/framework/13-inch/common/amd.nix"

    # framework kernel module
    "${flakes.nixos-hardware}/framework/kmod.nix"

    # framework-tool command line interface
    "${flakes.nixos-hardware}/framework/framework-tool.nix"

    ../common/utils.nix
    ../common/tpm.nix
    ../common/wifi.nix
    ../common/bluetooth.nix
    ../common/audio.nix
  ];

  nixpkgs.hostPlatform = {
    system = "x86_64-linux";
  };

  # AMD GPU computing framework
  nixpkgs.config.rocmSupport = true;

  hardware.enableRedistributableFirmware = true;

  # firmware updater
  services.fwupd.enable = true;

  # ethernet expansion card support
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0bda", ATTR{idProduct}=="8156", ATTR{power/autosuspend}="20"
  '';

  # main disk
  disko.devices.disk.main.device = "/dev/nvme0n1";
}
