{ user, ... }:
{
  home-manager.users.${user} = {
    programs.claude-code = {
      enable = true;

      settings = {
        theme = "dark";
      };
    };

    programs.git.ignores = [
      ".claude"
    ];
  };

  intransience.datastores.home.users.${user} = {
    files = [
      ".config/claude/.claude.json"
      ".config/claude/.credentials.json"
    ];

    dirs = [
      ".config/claude/projects"
    ];
  };
}
