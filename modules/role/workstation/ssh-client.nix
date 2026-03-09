{user, ...}: {
  home-manager.users.${user} = {
    programs.ssh = {
      enable = true;
      # check if this is necessary in the future
      enableDefaultConfig = false;

      matchBlocks = {
        github = {
          hostname = "github.com";
          user = "git";
        };
      };
    };

    # ssh-tpm-keygen -C insert_comment
    services.ssh-tpm-agent = {
      enable = true;
    };
  };

  intransience.datastores.home.users.${user}.dirs = [
    ".ssh"
  ];
}
