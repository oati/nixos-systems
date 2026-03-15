{
  user,
  pkgs,
  ...
}: {
  services.ddccontrol = {
    enable = true;
    package = pkgs.ddcutil-service;
  };

  users.users.${user}.extraGroups = ["i2c"];
}
