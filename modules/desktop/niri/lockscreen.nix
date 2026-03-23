{pkgs, ...}: {
  programs.gtklock = {
    enable = true;

    modules = with pkgs; [
      gtklock-powerbar-module
      gtklock-playerctl-module
    ];
  };
}
