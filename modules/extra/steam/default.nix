{user, ...}: {
  imports = [
    ./niri-window-rules.nix
  ];

  programs.steam = {
    enable = true;
  };

  intransience.datastores.games.users.${user}.dirs = [
    ".local/share/Steam"

    # game specific data
    ".config/unity3d"
    ".local/share/Celeste"
  ];
}
