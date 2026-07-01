{
  user,
  pkgs,
  ...
}:
{
  home-manager.users.${user} = {
    programs.niri = {
      settings = {
        environment = {
          QT_QPA_PLATFORM = "wayland";
        };

        includes = [
          (toString (
            pkgs.writeText "extra-config.kdl"
              # kdl
              ''
                // disable recent windows keybinds
                recent-windows {
                  off
                }
              ''
          ))
        ];
      };
    };
  };
}
