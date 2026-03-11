{user, ...}: {
  services.userborn.enable = true;

  users = {
    mutableUsers = false;

    users.${user} = {
      description = "Erin";
      isNormalUser = true;
      # sudoer
      extraGroups = ["wheel"];
      # mkpasswd -m yescrypt -s
      hashedPasswordFile = "/var/lib/secrets/${user}-password";
    };
  };

  security.sudo.enable = false;

  # no password for wheel
  security.run0.wheelNeedsPassword = false;

  intransience.datastores.system.files = [
    "/var/lib/secrets"
  ];

  fileSystems."/var/lib/secrets".neededForBoot = true;
}
