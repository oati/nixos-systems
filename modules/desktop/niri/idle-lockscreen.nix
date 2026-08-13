{
  user,
  lib,
  pkgs,
  ...
}:
{
  programs.gtklock = {
    enable = true;

    modules = [
      pkgs.gtklock-powerbar-module
    ];
  };

  home-manager.users.${user} = {
    services.swayidle = {
      enable = true;

      # wait for command to finish
      extraArgs = [ "-w" ];

      events.before-sleep = lib.getExe pkgs.gtklock;
    };
  };
}
