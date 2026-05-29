{ user, ... }:
{
  home-manager.users.${user} = {
    programs.niri = {
      settings = {
        input.mouse = {
          accel-profile = "flat";
          # range [-1, 1]
          accel-speed = -0.5;
        };
      };
    };
  };
}
