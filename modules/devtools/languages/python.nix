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

        # use symlinks for uv cache
        link-mode = "symlink";
      };
    };

    programs.nushell.extraConfig =
      # nu
      ''
        # delete uv cache entries that no project symlinks to
        def "uv clean" [] {
          let projects: string = xdg-user-dir PROJECTS | into string
          let archive: string = "~/.cache/uv/archive-v0" | path expand

          # archive entries with symlinks
          let live: list<string> = (
            ^find $projects -type l -lname ($archive | path join "*") -printf "%l\n"
              | lines
              | each { $in | path relative-to $archive | path split | first }
              | uniq
          )

          # archive entries with no symlinks
          let dead: list<string> = (
            ls $archive | get name | where { ($in | path basename) not-in $live }
          )

          if ($dead | is-empty) {
            print $"keeping ($live | length), deleting 0 entries"
            return
          }

          let size: filesize = du ...$dead | get physical | math sum
          print $"keeping ($live | length), deleting ($dead | length) entries, ($size)"

          rm -rf ...$dead
        }
      '';
  };

  # see https://docs.astral.sh/uv/reference/storage
  intransience.datastores.cache.users.${user}.dirs = [
    ".cache/uv"
  ];
}
