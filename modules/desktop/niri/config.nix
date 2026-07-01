{ user, ... }:
{
  home-manager.users.${user} = {
    programs.niri = {
      settings = {
        environment = {
          QT_QPA_PLATFORM = "wayland";
        };
      };
    };
  };
}
