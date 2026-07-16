{
  user,
  pkgs,
  ...
}:
{
  home-manager.users.${user} = {
    programs.mpv = {
      enable = true;

      scripts =
        let
          p = pkgs.mpvScripts;
        in
        [
          p.mpris

          # on screen controller
          p.uosc
          # thumbnails on timeline
          p.thumbfast

          # youtube
          p.sponsorblock
        ];

      defaultProfiles = [
        "high-quality"
      ];

      profiles.pseudo-gui.screenshot-directory = "~/screenshots";

      config = {
        # don't close window at the end of playback
        keep-open = "yes";
        cursor-autohide = 100; # ms
        save-position-on-quit = true;
        write-filename-in-watch-later-config = true;

        # ~> mpv --help=watch-later-options
        watch-later-options = builtins.concatStringsSep "," [
          "start"
          "aid"
          "vid"
          "sid"
          "audio-delay"
          "sub-delay"
          "sub-visibility"
        ];

        hwdec = "auto";
        video-sync = "display-resample";

        # audio and subtitles
        alang = "ja,jp,en,eng";
        slang = "en,eng";
      };
    };

    # browser extension configuration
    xdg.configFile."ff2mpv-rust.json".text = builtins.toJSON {
      player_command = "mpv";
      player_args = [
        "--player-operation-mode=pseudo-gui"
        # don't persist video positions from browser
        "--watch-later-dir=~~state/watch_later_browser"
        "--"
      ];
    };
  };

  intransience.datastores.cache.users.${user}.dirs = [
    # saved positions
    ".local/state/mpv/watch_later"
  ];
}
