{
  user,
  pkgs,
  ...
}: {
  home-manager.users.${user} = {
    programs.mpv = {
      enable = true;

      scripts = with pkgs.mpvScripts; [
        mpris

        # on screen controller
        uosc
        # thumbnails on timeline
        thumbfast

        # youtube
        sponsorblock
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

        # mpv --help=watch-later-options
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
  };

  intransience.datastores.cache.users.${user}.dirs = [
    # saved positions
    ".local/state/mpv/watch_later"
  ];
}
