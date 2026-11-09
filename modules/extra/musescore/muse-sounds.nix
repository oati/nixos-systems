{
  user,
  lib,
  pkgs,
  ...
}:
{
  home-manager.users.${user} =
    { config, ... }:
    let
      installLocation = "${config.xdg.dataHome}/MuseSounds";
    in
    {
      home.packages = [ pkgs.muse-sounds-manager ];

      # used by musescore
      xdg.dataFile."MuseSampler/.config".text = "${installLocation}/Muse Sounds";

      # used by muse-sounds-manager
      xdg.dataFile."muse-sounds-manager/settings.json".text = lib.toJSON {
        AppLanguage = "en-US";
        AutomaticallyKeepApplicationsUpToDate = false;
        AutomaticallyKeepSoundsUpToDate = false;
        MuseDownloadLocation = installLocation;
      };
    };

  intransience.datastores.home.users.${user} = {
    dirs = [
      # muse sounds
      ".local/share/MuseSounds"
      # sampler engine library for musescore
      ".local/share/MuseSampler/lib"
    ];

    files = [
      # signed license receipt
      ".local/share/muse-sounds-manager/.receipt"
    ];
  };
}
