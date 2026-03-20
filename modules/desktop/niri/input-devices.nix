{user, ...}: {
  home-manager.users.${user} = {
    programs.niri = {
      settings = {
        input.mouse = {
          accel-profile = "flat";
          accel-speed = 0.25;
        };
      };
    };
  };
}
