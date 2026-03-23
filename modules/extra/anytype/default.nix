{
  user,
  pkgs,
  ...
}: {
  imports = [
    ./appearance.nix
  ];

  environment.systemPackages = [pkgs.anytype];

  intransience.datastores.home.users.${user}.dirs = [
    ".config/anytype"
  ];
}
