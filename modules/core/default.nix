# core options for every system
{flakes, ...}: {
  imports = [
    flakes.disko.nixosModules.default
    flakes.intransience.nixosModules.default
    flakes.home-manager.nixosModules.default

    ./nixpkgs.nix
    ./nix-config.nix
    ./users.nix
    ./home.nix
    ./shell.nix
    ./networking.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 5;
    };

    initrd.systemd.enable = true;
  };

  system.etc.overlay = {
    enable = true;
    mutable = false;
  };

  services.dbus.implementation = "broker";

  home-manager = {
    # use system pkgs
    useGlobalPkgs = true;
    # allow home manager to add packages
    useUserPackages = true;
    backupFileExtension = "hm-backup";
  };

  intransience.datastores = {
    system.etc.dirs = [
      "nixos"
    ];

    system.dirs = [
      "/var/log"
      "/var/lib/systemd"
      "/var/lib/nixos"
    ];

    cache.dirs = [
      "/var/cache"
    ];
  };

  system.configurationRevision = flakes.self.shortRev or flakes.self.dirtyShortRev;
}
