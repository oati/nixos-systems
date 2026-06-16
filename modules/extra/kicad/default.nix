{ user, pkgs, ... }:
let
  package = pkgs.symlinkJoin {
    pname = "kicad-custom";
    inherit (pkgs.kicad) version;
    paths = [ pkgs.kicad ];

    # clean up desktop entries
    postBuild = ''
      rm $out/share/applications
      mkdir $out/share/applications
      cp ${pkgs.kicad}/share/applications/org.kicad.kicad.desktop $out/share/applications
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
