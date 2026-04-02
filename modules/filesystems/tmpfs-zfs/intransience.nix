{config, ...}: {
  intransience = {
    enable = true;

    datastores = {
      system.path = "/safe/system";
      home.path = "/safe/home";
      cache.path = "/local/cache";
      games.path = "/local/games";
    };
  };

  # set neededForBoot for system datastore
  fileSystems.${config.intransience.datastores.system.path}.neededForBoot = true;
}
