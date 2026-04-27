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

      userDirs = let
        homeDir = config.home.homeDirectory;
      in {
        enable = true;
        createDirectories = true;
        desktop = null;
        documents = "${homeDir}/documents";
        download = "${homeDir}/downloads";
        projects = "${homeDir}/projects";
        music = null;
        pictures = null;
        videos = null;
        publicShare = null;
        templates = null;
      };

      mimeApps.enable = true;
    };
  };

  # workaround for intransience bug
  intransience.datastores.cache.users.${user}.dirs = [
    ".local/meow"
    ".local/state/meow"
  ];
}
