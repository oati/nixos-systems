{
  user,
  config,
  ...
}: {
  home-manager.users.${user} = {
    programs.jujutsu = {
      enable = true;

      settings = {
        inherit (config.home-manager.users.${user}.programs.git.settings) user;

        ui = {
          default-command = "status";
        };
      };
    };

    programs.difftastic = {
      enable = true;
      jujutsu.enable = true;
    };

    programs.jjui.enable = true;
  };
}
