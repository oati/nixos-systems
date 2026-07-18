{
  user,
  pkgs,
  ...
}:
let
  package = pkgs.symlinkJoin {
    name = "nautilus-custom";
    inherit (pkgs.nautilus) version meta;
    paths = [ pkgs.nautilus ];

    # make desktop entry open in new window
    # remove DBusActivatable=true since it ignores Exec
    postBuild = ''
      pushd $out/share/applications
      rm org.gnome.Nautilus.desktop
      cp ${pkgs.nautilus}/share/applications/org.gnome.Nautilus.desktop .
      sed -i '/^DBusActivatable=true$/d' org.gnome.Nautilus.desktop
      popd
    '';
  };
in
{
  home-manager.users.${user} = {
    home.packages = [ package ];

    xdg.mimeApps.defaultApplicationPackages = [ package ];
  };
}
