{ user, ... }:
{
  home-manager.users.${user} = {
    programs.difftastic = {
      enable = true;

      git.enable = true;
      jujutsu.enable = true;

      options = {
        override-binary = [
          # cad
          "*.dxf"
          "*.stp"
          "*.step"
        ];
      };
    };
  };
}
