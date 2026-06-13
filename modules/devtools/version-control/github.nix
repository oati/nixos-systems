{ user, ... }:
{
  home-manager.users.${user} = {
    programs.gh = {
      enable = true;

      # https://cli.github.com/manual/gh_config
      settings = {
        git_protocol = "ssh";
        telemetry = "disabled";
      };
    };
  };

  intransience.datastores.home.users.${user}.files = [
    ".config/gh/hosts.yml"
  ];
}
