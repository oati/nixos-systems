{
  user,
  pkgs,
  ...
}:
let
  package = pkgs.symlinkJoin {
    name = "osu-lazer-bin-wrapped";
    inherit (pkgs.osu-lazer-bin) version meta;

    paths = [
      (pkgs.osu-lazer-bin.override {
        nativeWayland = true;
      })
    ];

    nativeBuildInputs = [ pkgs.makeBinaryWrapper ];

    # set audio buffer size
    # see https://github.com/ppy/osu-framework/blob/0c3fb255384f24804e4797a31a656b340cb641d6/osu.Framework/Audio/AudioManager.cs#L382
    postBuild = ''
      wrapProgram $out/bin/osu! \
        --set OSU_TEMP_TESTING_BASS_CONFIG_DEV_PERIOD 4 # ms
    '';
  };
in
{
  imports = [
    ./niri-window-rules.nix
  ];

  home-manager.users.${user} = {
    home.packages = [ package ];
  };

  intransience.datastores.games.users.${user}.dirs = [
    ".local/share/osu"
  ];
}
