# system used as a personal computer
{user, ...}: {
  imports = [
    # TODO
    # ../common/ssh-server.nix
    ./networking.nix
    ./ssh-client.nix
    ./fonts.nix
    ./terminal.nix
    ./browser.nix
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
