{
  user,
  lib,
  pkgs,
  ...
}:
let
  armel-uv-k1-driver = pkgs.fetchurl {
    url = "https://github.com/armel/uv-k1-k5v3-firmware-custom/releases/download/v5.5.0/f4hwn.fusion.chirp.v5.5.0.py";
    hash = "sha256-3yQSQ5SacJIIZLkoSZAofU57oAKA4fNoQaC0mMbNIDw=";
  };

  package = pkgs.chirp.overrideAttrs (prevAttrs: {
    postInstall = (prevAttrs.postInstall or "") + ''
      cp ${armel-uv-k1-driver} \
        $out/${pkgs.python3.sitePackages}/chirp/drivers/F4HWN.py
    '';
  });
in
{
  home-manager.users.${user} = {
    home.packages = [ package ];

    xdg.desktopEntries.chirp = {
      type = "Application";
      name = "CHIRP";
      genericName = "Radio Programming Tool";
      comment = "Program amateur radios";
      categories = [
        "Utility"
        "HamRadio"
      ];
      icon = "${package}/${pkgs.python3.sitePackages}/chirp/share/chirp.ico";

      exec = lib.getExe' package "chirp";
      mimeType = [ "x-scheme-handler/chirp" ];
      startupNotify = true;
    };
  };

  intransience.datastores.home.users.${user}.dirs = [
    ".chirp"
  ];
}
