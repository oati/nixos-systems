{ user, ... }:
{
  home-manager.users.${user} = {
    programs.niri.settings.window-rules = [
      # steam notifications
      {
        matches = [
          { app-id = "steam"; }
          { title = "^notificationtoasts_\\d+_desktop$"; }
        ];

        default-floating-position = {
          relative-to = "bottom-right";
          x = 10;
          y = 10;
        };
      }
    ];
  };
}
