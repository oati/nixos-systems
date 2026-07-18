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
      ".claude.json"
      ".claude/.credentials.json"
    ];

    dirs = [
      ".claude/projects"
    ];
  };
}
