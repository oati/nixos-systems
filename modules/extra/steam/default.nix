{
  user,
  pkgs,
  ...
}: {
  imports = [
    ./niri-window-rules.nix
  ];

  programs.steam = {
    enable = true;

    package = pkgs.steam.override {
      extraEnv = {
        # force proton to use wayland
        PROTON_ENABLE_WAYLAND = 1;
      };
    };

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  programs.gamemode.enable = true;

  intransience.datastores.games.users.${user}.dirs = [
    ".local/share/Steam"
  ];

  intransience.datastores.gamedata.users.${user}.dirs = [
    ".config/unity3d"
    ".local/share/Celeste"
  ];
}
