# system used as a personal computer
{
  user,
  pkgs,
  ...
}: {
  imports = [
    ../common/vpn
    ./fonts.nix
    ./theme.nix
    ./networking.nix
    ./ssh-client.nix
    ./terminal.nix
    ./file-manager.nix
    ./media-player.nix
    ./pdf-viewer
    ./browser
  ];

  home-manager.users.${user} = {
    home.packages = with pkgs; [
      # audio and video downloader
      yt-dlp

      # wayland event viewer
      wev
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
