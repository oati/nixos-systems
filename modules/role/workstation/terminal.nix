{user, ...}: {
  home-manager.users.${user} = {
    programs.ghostty = {
      enable = true;
      systemd.enable = true;

      settings = {
        theme = "modus-vivendi";
        # font-size
      };

      themes.modus-vivendi = {
        background = "#000000";
        foreground = "#ffffff";
        selection-background = "#5a5a5a";
        selection-foreground = "#ffffff";
        cursor-color = "#ffffff";
        palette = [
          # black
          "0=#1e1e1e"
          "8=#535353"
          # red
          "1=#ff5f59"
          "9=#ff7f9f"
          # green
          "2=#44bc44"
          "10=#00c06f"
          # yellow
          "3=#d0bc00"
          "11=#dfaf7a"
          # blue
          "4=#2fafff"
          "12=#00bcff"
          # magenta
          "5=#feacd0"
          "13=#b6a0ff"
          # cyan
          "6=#00d3d0"
          "14=#6ae4b9"
          # white
          "7=#ffffff"
          "15=#989898"
        ];
      };
    };
  };
}
