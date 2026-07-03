# unlock gpg keys on login
# signal-desktop uses secret service on startup

{ user, ... }:
{
  home-manager.users.${user} = {
    services.gpg-agent.extraConfig = ''
      allow-preset-passphrase
    '';
  };

  security.pam.services.login.gnupg = {
    enable = true;
    noAutostart = true;
    storeOnly = true;
  };

  intransience.datastores.home.users.${user}.files = [
    {
      path = ".pam-gnupg";
      mode = "0600";
    }
  ];
}
