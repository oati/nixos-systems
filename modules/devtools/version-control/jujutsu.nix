{ user, config, ... }:
{
  home-manager.users.${user} =
    { config, ... }:
    {
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
    };

  environment.systemPackages = [
    config.home-manager.users.${user}.programs.jujutsu.package
  ];
}
