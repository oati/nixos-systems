{ user, ... }:
{
  home-manager.users.${user} = {
    programs.claude-code = {
      enable = true;

      settings = {
        theme = "dark";
      };
    };
  };

  intransience.datastores.home.users.${user} = {
    files = [
      ".claude/.credentials.json"
    ];

    dirs = [
      ".claude/projects"
    ];
  };
}
