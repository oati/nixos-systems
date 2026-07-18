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
  boot.kernelParams =
    let
      GB = 1024 * 1024 * 1024;
    in
    [
      # ZFS cache size
      "zfs.zfs_arc_max=${toString (8 * GB)}"
      # amount of RAM that ZFS cache should leave free
      "zfs.zfs_arc_sys_free=${toString (4 * GB)}"
    ];
}
