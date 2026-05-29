{
  user,
  lib,
  ...
}:
{
  home-manager.users.${user} = {
    programs.niri = {
      settings = {
        environment = {
          QT_QPA_PLATFORM = "wayland";
        };
      };
    };

    # workaround to add custom configs
    xdg.configFile."niri/config.kdl".text =
      # kdl
      ''
        include "generated-config.kdl"

        // disable recent windows keybinds
        recent-windows {
          off
        }
      '';

    xdg.configFile.niri-config.target = lib.mkForce "niri/generated-config.kdl";
  };
}
