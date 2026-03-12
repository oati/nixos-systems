{user, ...}: {
  # kernel console
  stylix.targets.console.enable = true;

  services.kmscon = {
    enable = true;
    hwRender = true;

    extraConfig = let
      # hidpi scaling
      scale = 1.5;
    in "font-dpi=${toString (96 * scale)}";
  };

  stylix.targets.kmscon.enable = true;

  home-manager.users.${user} = {
    programs.ghostty = {
      enable = true;
      systemd.enable = true;
    };

    stylix.targets.ghostty.enable = true;
  };
}
