{
  user,
  lib,
  pkgs,
  ...
}: let
  package = pkgs.chirp;
in {
  home-manager.users.${user} = {
    home.packages = [package];

    xdg.desktopEntries.chirp = {
      type = "Application";
      name = "CHIRP";
      genericName = "Radio Programming Tool";
      comment = "Program amateur radios";
      categories = ["Utility" "HamRadio"];
      icon = "${package}/${pkgs.python3.sitePackages}/chirp/share/chirp.ico";

      exec = lib.getExe' package "chirp";
      mimeType = ["x-scheme-handler/chirp"];
      startupNotify = true;
    };
  };

  intransience.datastores.home.users.${user}.dirs = [
    ".chirp"
  ];
}
