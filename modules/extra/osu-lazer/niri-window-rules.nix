{ user, ... }:
{
  home-manager.users.${user} = {
    programs.niri.settings.window-rules = [
      {
        matches = [
          { app-id = "osu!"; }
        ];

        open-maximized = true;
      }
    ];
  };
}
