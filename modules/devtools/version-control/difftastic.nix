{ user, ... }:
{
  home-manager.users.${user} = {
    programs.difftastic = {
      enable = true;

      git.enable = true;
      jujutsu.enable = true;
    };
  };
}
