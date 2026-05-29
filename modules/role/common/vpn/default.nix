{ user, ... }:
{
  services.netbird = {
    ui.enable = false;

    clients.default = {
      name = "netbird";
      port = 51820;
      interface = "vpn0";

      # see https://github.com/NixOS/nixpkgs/issues/506156
      hardened = false;
    };
  };

  users.users.${user}.extraGroups = [ "netbird" ];

  intransience.datastores.system.dirs = [
    "/var/lib/netbird"
  ];
}
