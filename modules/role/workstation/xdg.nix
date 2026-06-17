{ user, pkgs, ... }:
{
  home-manager.users.${user} = {
    xdg = {
      userDirs.createDirectories = true;
      mimeApps.enable = true;
    };
  };

  # workaround for gtk3 file picker crash
  # https://github.com/NixOS/nixpkgs/issues/149812
  environment.sessionVariables.XDG_DATA_DIRS = [
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
  ];
}
