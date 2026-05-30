{
  user,
  pkgs,
  config,
  ...
}:
{
  home-manager.users.${user} = {
    programs.ssh = {
      enable = true;
      # check if this is necessary in the future
      enableDefaultConfig = false;

      settings = {
        github = {
          hostname = "github.com";
          user = "git";
        };
      };
    };

    # ssh-tpm-keygen -C <comment>
    services.ssh-tpm-agent.enable = config.security.tpm2.enable;

    home.packages = [
      pkgs.sshfs
    ];
  };

  intransience.datastores.home.users.${user}.dirs = [
    ".ssh"
  ];
}
