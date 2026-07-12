{ ... }:
{
  imports = [
    ./disks.nix
    ./intransience.nix
  ];

  services.zfs = {
    autoScrub.enable = true;
    autoSnapshot.enable = true;
  };

  intransience.datastores.system.etc.files = [
    "zfs/zpool.cache"
  ];

  # workaround for https://github.com/openzfs/zfs/issues/10255
  # amount of RAM that ZFS cache should leave free
  boot.extraModprobeConfig = "options zfs zfs_arc_sys_free=${toString (4 * 1073741824)}"; # 4 GB
}
