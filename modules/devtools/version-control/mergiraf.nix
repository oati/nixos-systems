{ user, ... }:
{
  home-manager.users.${user} = {
    programs.mergiraf = {
      enable = true;

      enableGitIntegration = true;
      enableJujutsuIntegration = true;
    };
  };
}
