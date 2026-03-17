{user, ...}: {
  home-manager.users.${user} = {
    programs.fuzzel = {
      enable = true;
    };
  };
}
