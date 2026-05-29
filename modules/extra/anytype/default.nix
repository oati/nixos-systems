{
  user,
  pkgs,
  ...
}:
let
  package = pkgs.anytype;
in
{
  imports = [
    ./appearance.nix
  ];

  home-manager.users.${user} = {
    home.packages = [ package ];

    # prevent anytype from automatically creating bad desktop entry
    xdg.dataFile."applications/anytype.desktop" = {
      source = "${package}/share/applications/anytype.desktop";
      force = true;
    };
  };

  intransience.datastores.home.users.${user}.dirs = [
    ".config/anytype"
  ];
}
