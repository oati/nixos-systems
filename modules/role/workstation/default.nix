# system used as a personal computer
{
  user,
  pkgs,
  ...
}:
{
  imports = [
    ../common/vpn
    ./xdg.nix
    ./fonts.nix
    ./theme.nix
    ./networking.nix
    ./ssh-client.nix
    ./terminal.nix
    ./file-manager.nix
    ./media-player.nix
    ./pdf-viewer
    ./email-client.nix
    ./browser
  ];

  home-manager.users.${user} = {
    home.packages = [
      # audio and video downloader
      pkgs.yt-dlp

      # wayland event viewer
      pkgs.wev
    ];
  };

  intransience.datastores.system.byPath."/var/lib".dirs = [
    # audio
    # "alsa"

    # printer
    "cups"
  ];

  intransience.datastores.home.users.${user}.dirs = [
    "documents"
    "projects"
  ];
}
