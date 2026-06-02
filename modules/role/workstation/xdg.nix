{ user, ... }:
{
  home-manager.users.${user} = {
    xdg = {
      userDirs.createDirectories = true;
      mimeApps.enable = true;
    };
  };
}
