{
  user,
  pkgs,
  ...
}: {
  home-manager.users.${user} = {
    programs.niri.settings.binds = {
      # niri
      "Mod+Tab".action.toggle-overview = {};
      "Mod+slash".action.show-hotkey-overlay = {};
      # "Mod+Escape".action.spawn = [{allow-inhibiting = false;} "lock"];

      # focus
      "Mod+Shift+U".action.focus-workspace-up = {};
      "Mod+Shift+E".action.focus-workspace-down = {};

      "Mod+U".action.focus-window-up = {};
      "Mod+E".action.focus-window-down = {};
      "Mod+D".action.focus-column-left = {};
      "Mod+A".action.focus-column-right = {};
      "Mod+W".action.focus-column-first = {};
      "Mod+O".action.focus-column-last = {};

      "Mod+WheelScrollUp".action.focus-column-left = {};
      "Mod+WheelScrollDown".action.focus-column-right = {};

      "Mod+comma".action.switch-focus-between-floating-and-tiling = {};

      # move
      "Mod+Ctrl+Shift+U".action.move-column-to-workspace-up = {};
      "Mod+Ctrl+Shift+E".action.move-column-to-workspace-down = {};
      "Mod+Alt+Shift+U".action.move-workspace-up = {};
      "Mod+Alt+Shift+E".action.move-workspace-down = {};

      "Mod+Ctrl+U".action.move-window-up = {};
      "Mod+Ctrl+E".action.move-window-down = {};
      "Mod+Ctrl+D".action.move-column-left = {};
      "Mod+Ctrl+A".action.move-column-right = {};
      "Mod+Ctrl+W".action.move-column-to-first = {};
      "Mod+Ctrl+O".action.move-column-to-last = {};

      "Mod+Ctrl+comma".action.toggle-window-floating = {};

      # column
      "Mod+Ctrl+G".action.consume-or-expel-window-left = {};
      "Mod+Ctrl+period".action.consume-or-expel-window-right = {};

      # window
      "Mod+T".action.toggle-column-tabbed-display = {};
      "Mod+R".action.switch-preset-column-width-back = {};
      "Mod+N".action.switch-preset-column-width = {};
      "Mod+M".action.maximize-column = {};
      "Mod+F".action.fullscreen-window = {};
      "Mod+Ctrl+F".action.toggle-windowed-fullscreen = {};
      "Mod+Q".action.close-window = {};

      # commands
      "Mod+space".action.spawn = "fuzzel";
      "Mod+P".action.screenshot = {};
      "Mod+Ctrl+P".action.screenshot-window.write-to-disk = false;
      "Mod+Ctrl+Shift+P".action.screenshot-window = {};
      "Mod+Alt+P".action.screenshot-screen.write-to-disk = false;
      "Mod+Alt+Shift+P".action.screenshot-screen = {};

      XF86AudioRaiseVolume.action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+" "--limit" "1.0"];
      XF86AudioLowerVolume.action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"];
      XF86AudioMute.action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];

      XF86AudioPlay.action.spawn = ["playerctl" "play-pause"];
      XF86AudioStop.action.spawn = ["playerctl" "stop"];
      XF86AudioPrev.action.spawn = ["playerctl" "previous"];
      XF86AudioNext.action.spawn = ["playerctl" "next"];

      # XF86MonBrightnessUp
      # XF86MonBrightnessDown
    };
  };

  environment.systemPackages = with pkgs; [
    playerctl
  ];
}
