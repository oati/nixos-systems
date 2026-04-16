# system used as a personal computer
{user, ...}: {
  imports = [
    ../common/vpn
    ./fonts.nix
    ./theme.nix
    ./networking.nix
    ./ssh-client.nix
    ./terminal.nix
    ./file-manager.nix
    ./pdf-viewer
    ./browser
  ];

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
