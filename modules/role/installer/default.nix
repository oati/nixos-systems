# NixOS installer
# see https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/installation-device.nix
{
  user,
  lib,
  pkgs,
  ...
}: {
  users.users.${user} = {
    hashedPasswordFile = lib.mkForce null;
    initialPassword = "";
  };

  boot.supportedFilesystems.zfs = true;

  # options for low memory conditions
  environment.variables.GC_INITIAL_HEAP_SIZE = "1M";
  boot.kernel.sysctl."vm.overcommit_memory" = "1";

  # include in nix store
  system.extraDependencies = [
    pkgs.busybox
    # for runCommand
    pkgs.stdenvNoCC
    # for boot.initrd.systemd
    pkgs.makeInitrdNGTool
  ];
}
