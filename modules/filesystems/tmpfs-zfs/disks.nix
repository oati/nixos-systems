{...}: {
  disko.devices = {
    # partitions
    disk.main = {
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["umask=0077"];
            };
          };
          zfs = {
            size = "100%";
            content = {
              type = "zfs";
              pool = "rpool";
            };
          };
          swap = {
            size = "32G";
            content = {
              type = "swap";
              randomEncryption = true;
            };
          };
        };
      };
    };

    # tmpfs on root
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=100%"
        "huge=within_size"
        "mode=755"
      ];
    };

    # zfs pool
    zpool.rpool = {
      type = "zpool";
      rootFsOptions = {
        canmount = "off";
        mountpoint = "none";
        compression = "zstd";
        xattr = "sa";
        acltype = "posixacl";
      };
      options.ashift = "12";

      datasets = {
        "encrypt" = {
          type = "zfs_fs";
          options = {
            encryption = "on";
            keyformat = "passphrase";
          };
        };

        "reserved" = {
          type = "zfs_fs";
          options.refreservation = "10G";
        };

        "encrypt/safe" = {
          type = "zfs_fs";
          options."com.sun:auto-snapshot" = "true";
        };
        "encrypt/safe/system" = {
          type = "zfs_fs";
          mountpoint = "/safe/system";
          options.mountpoint = "legacy";
        };
        "encrypt/safe/home" = {
          type = "zfs_fs";
          mountpoint = "/safe/home";
          options.mountpoint = "legacy";
        };
        "encrypt/safe/gamedata" = {
          type = "zfs_fs";
          mountpoint = "/safe/gamedata";
          options.mountpoint = "legacy";
        };

        "encrypt/local" = {
          type = "zfs_fs";
        };
        "encrypt/local/nix" = {
          type = "zfs_fs";
          mountpoint = "/nix";
          options.mountpoint = "legacy";
        };
        "encrypt/local/cache" = {
          type = "zfs_fs";
          mountpoint = "/local/cache";
          options.mountpoint = "legacy";
        };
        "encrypt/local/media" = {
          type = "zfs_fs";
          mountpoint = "/local/media";
          options.mountpoint = "legacy";
        };
        "encrypt/local/games" = {
          type = "zfs_fs";
          mountpoint = "/local/games";
          options.mountpoint = "legacy";
        };

        "encrypt/local/vms" = {
          type = "zfs_fs";
        };
        "encrypt/local/vms/windows" = {
          type = "zfs_volume";
          size = "128G";
        };
      };
    };
  };
}
