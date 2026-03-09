{...}: {
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
}
