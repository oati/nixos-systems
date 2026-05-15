{user, ...}: {
  home-manager.users.${user} = {
    programs.mangohud = {
      enable = true;

      settings = {
        full = true;

        toggle_hud = "Shift_L+F12";
        toggle_hud_position = "Shift_L+F11";
        toggle_preset = "Shift_L+F10";
        toggle_fps_limit = "Shift_L+F1";
        toggle_logging = "Shift_L+F2";
        reload_cfg = "Shift_L+F4";
        upload_log = "Shift_L+F3";
        reset_fps_metrics = "Shift_L+F9";
      };
    };
  };
}
