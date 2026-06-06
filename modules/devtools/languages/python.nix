{ user, ... }:
{
  home-manager.users.${user} = {
    programs.helix.languages = {
      language = [
        {
          name = "python";
          auto-format = true;
        }
      ];
    };

    programs.uv = {
      enable = true;

      settings = {
        # do not manage python installations
        python-downloads = "never";
        python-preference = "only-system";
      };
    };
  };

  # see https://docs.astral.sh/uv/reference/storage
  intransience.datastores.cache.users.${user}.dirs = [
    ".cache/uv"
  ];
}
