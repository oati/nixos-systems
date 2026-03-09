{user, ...}: {
  home-manager.users.${user} = {
    programs.nix-index = {
      enable = true;
    };

    programs.nix-your-shell = {
      enable = true;
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
