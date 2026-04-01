{
  user,
  lib,
  pkgs,
  ...
}: {
  programs.gtklock = {
    enable = true;

    modules = with pkgs; [
      gtklock-powerbar-module
      gtklock-playerctl-module
    ];
  };

  home-manager.users.${user} = {
    services.swayidle = {
      enable = true;

      # wait for command to finish
      extraArgs = ["-w"];

      events.before-sleep = lib.getExe pkgs.gtklock;
    };
  };
}
