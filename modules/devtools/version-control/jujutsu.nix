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
          pager = "moor -quit-if-one-screen";
        };
      };
    };

    programs.difftastic = {
      enable = true;
      jujutsu.enable = true;
    };

    programs.jjui.enable = true;

    stylix.targets.jjui.enable = true;
  };
}
