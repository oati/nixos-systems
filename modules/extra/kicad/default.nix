{ user, pkgs, ... }:
let
  package = pkgs.symlinkJoin {
    pname = "kicad-custom";
    inherit (pkgs.kicad) version meta;
    paths = [ pkgs.kicad ];

    # clean up desktop entries
    postBuild = ''
      rm -r $out/share/applications
      install -Dm644 -t $out/share/applications \
        ${pkgs.kicad}/share/applications/org.kicad.kicad.desktop
    '';
  };
in
{
  home-manager.users.${user} = {
    home.packages = [ package ];
  };

  intransience.datastores.home.users.${user}.dirs = [
    # ".config/kicad"
    # ".local/share/kicad"
  ];
}
