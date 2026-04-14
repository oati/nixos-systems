{user, ...}: {
  imports = [
    ./niri-window-rules.nix
  ];

  programs.steam = {
    enable = true;
  };

  intransience.datastores.games.users.${user}.dirs = [
    ".local/share/Steam"
  ];

  intransience.datastores.gamedata.users.${user}.dirs = [
    ".config/unity3d"
    ".local/share/Celeste"
  ];
}
