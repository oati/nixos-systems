{user, ...}: {
  services.openssh = {
    enable = true;
    ports = [22];
    openFirewall = false;

    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [user];
    };

    # TODO: use ssh-tpm-hostkeys when a nixos module for it is available
    hostKeys = [
      {
        path = "/var/opt/sshd/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  # ssh-add -L
  users.users.${user}.openssh.authorizedKeys.keys = [
    # erin-pc
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBHOeUwUN1EzzATtJuByXo6e4xWWFVJIx4m60HoPcVEG1Dn2pcbVBKYRJkEiREpbvGB0Jtt5fX281bu8tu8cBAFM= erin@erin-pc"

    # erin-iphone
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIsKH2DuzhBG/fO0Q/hskWbQBnGYWXscHzIwKoQ+wgLA erin-iphone"
  ];

  # expose ssh port to vpn
  networking.firewall.interfaces.vpn0.allowedTCPPorts = [22];

  intransience.datastores.system.dirs = [
    "/var/opt/sshd"
  ];
}
