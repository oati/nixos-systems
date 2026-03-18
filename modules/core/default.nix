# core options for every system
{flakes, ...}: {
  imports = [
    flakes.disko.nixosModules.default
    flakes.intransience.nixosModules.default
    flakes.home-manager.nixosModules.default
    flakes.stylix.nixosModules.default

    ./nixpkgs.nix
    ./nix-config.nix
    ./boot.nix
    ./users.nix
    ./home.nix
    ./shell
    ./networking.nix
  ];

  system.etc.overlay = {
    enable = true;
    mutable = false;
  };

  services.dbus.implementation = "broker";

  # faster shutdown
  systemd.settings.Manager.DefaultTimeoutStopSec = "5s";

  # revision metadata
  system.configurationRevision = flakes.self.shortRev or flakes.self.dirtyShortRev;

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
}
