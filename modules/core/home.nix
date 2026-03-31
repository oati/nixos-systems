{user, ...}: {
  home-manager = {
    # use system pkgs
    useGlobalPkgs = true;
    # allow home manager to add packages
    useUserPackages = true;

    backupFileExtension = "hm-backup";
  };

  home-manager.users.${user} = {config, ...}: {
    systemd.user.sessionVariables = config.home.sessionVariables;

    home = {
      preferXdgDirectories = true;
    };

    xdg = {
      enable = true;

      userDirs = {
        enable = true;
        createDirectories = true;
        desktop = null;
        documents = "$HOME/documents";
        download = "$HOME/downloads";
        music = null;
        pictures = null;
        videos = null;
        publicShare = null;
        templates = null;
      };
    };
  };

  # workaround for intransience bug
  intransience.datastores.cache.users.${user}.dirs = [
    ".local/meow"
  ];
}
