{
  user,
  config,
  ...
}: {
  home-manager.users.${user} = {
    systemd.user.sessionVariables = config.home-manager.users.${user}.home.sessionVariables;

    home = {
      preferXdgDirectories = true;
    };

    xdg = {
      enable = true;

      userDirs = {
        enable = true;
        createDirectories = true;
        desktop = null;
        documents = "~/documents";
        download = "~/downloads";
        music = null;
        pictures = null;
        videos = null;
        publicShare = null;
        templates = null;
      };
    };
  };

  intransience.datastores.cache.users.${user}.dirs = [
    ".cache"
  ];
}
