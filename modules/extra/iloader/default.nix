{
  user,
  pkgs,
  ...
}: {
  home-manager.users.${user} = {
    home.packages = [pkgs.iloader];
  };

  services.usbmuxd.enable = true;

  users.users.${user}.extraGroups = ["usbmux"];

  intransience.datastores.home.users.${user}.dirs = [
    ".local/share/me.nabdev.iloader"
  ];
}
