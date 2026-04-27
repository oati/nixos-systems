{user, ...}: {
  home-manager.users.${user} = {config, ...}: {
    programs.jujutsu = {
      enable = true;

      settings = {
        inherit (config.programs.git.settings) user;

        ui = {
          default-command = "status";
          pager = "moor -quit-if-one-screen";
        };
      };
    };

    programs.difftastic = {
      enable = true;
      jujutsu.enable = true;
    };

    programs.mergiraf = {
      enable = true;
      enableJujutsuIntegration = true;
    };
  };
}
