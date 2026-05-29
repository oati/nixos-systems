{ user, ... }:
{
  home-manager.users.${user} = {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "Erin";
          email = "79354991+oati@users.noreply.github.com";
        };
        init.defaultBranch = "main";
      };

      ignores = [
        ".helix"

        "result"
        ".envrc"
        ".direnv"
      ];
    };

    programs.difftastic = {
      enable = true;
      git.enable = true;
    };

    programs.mergiraf = {
      enable = true;
      enableGitIntegration = true;
    };

    programs.git-credential-oauth.enable = true;
  };
}
