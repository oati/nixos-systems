{user, ...}: {
  # kernel console
  stylix.targets.console.enable = true;

  # virtual console
  services.kmscon = {
    enable = true;
    hwRender = true;
  };

  stylix.targets.kmscon.enable = true;

  # terminal emulator
  home-manager.users.${user} = {
    programs.ghostty = {
      enable = true;

      settings = {
        resize-overlay-position = "bottom-right";

        notify-on-command-finish = "unfocused";
        notify-on-command-finish-action = "no-bell,notify";
        notify-on-command-finish-after = "5s";

        keybind = [
          # bind ctrl+backspace to alt+backspace
          "ctrl+backspace=text:\\x1b\\x7f"
        ];
      };
    };

    stylix.targets.ghostty.enable = true;

    xdg.terminal-exec = {
      enable = true;
      settings.default = ["com.mitchellh.ghostty.desktop"];
    };
  };
}
