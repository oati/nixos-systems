# system used as a personal computer
{user, ...}: {
  imports = [
    # TODO
    # ../common/ssh-server.nix
    ./fonts.nix
    ./theme.nix
    ./networking.nix
    ./ssh-client.nix
    ./terminal.nix
    ./file-manager.nix
    ./pdf-viewer.nix
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
  ];
}
