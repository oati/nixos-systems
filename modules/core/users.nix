{
  user,
  lib,
  pkgs,
  config,
  ...
}:
{
  services.userborn.enable = true;

  users = {
    mutableUsers = false;

    users.${user} = {
      description = "Erin";
      isNormalUser = true;
      # sudoer
      extraGroups = [ "wheel" ];
      # mkpasswd -m yescrypt -s
      hashedPasswordFile = "/var/lib/secrets/${user}-password";
    };
  };

  security.sudo.enable = false;
  security.run0.enable = true;

  # no password for wheel
  security.run0.wheelNeedsPassword = false;

  # sudo alias for run0
  environment.systemPackages = [
    (pkgs.writeScriptBin "sudo" ''
      #!${lib.getExe pkgs.dash}
      exec run0 "$@"
    '')
  ];

  intransience.datastores.system.files = [
    "/var/lib/secrets"
  ];

  fileSystems."/var/lib/secrets" = lib.mkIf config.intransience.enable { neededForBoot = true; };
}
