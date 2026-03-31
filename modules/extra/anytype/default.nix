{
  user,
  pkgs,
  ...
}: {
  imports = [
    ./appearance.nix
  ];

  home-manager.users.${user} = {
    home.packages = [pkgs.anytype];

    # prevent anytype from automatically creating bad desktop entry
    xdg.dataFile."applications/anytype.desktop" = {
      source = "${pkgs.anytype}/share/applications/anytype.desktop";
      force = true;
    };
  };

  intransience.datastores.home.users.${user}.dirs = [
    ".config/anytype"
  ];
}
