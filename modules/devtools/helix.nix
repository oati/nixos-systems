{ user, ... }:
{
  home-manager.users.${user} =
    { config, ... }:
    {
      programs.helix = {
        enable = true;

        settings = {
          editor = {
            cursor-shape = {
              normal = "block";
              select = "underline";
              insert = "bar";
            };

            soft-wrap.enable = true;
          };

          keys = {
            insert = {
              C-left = "move_prev_word_start";
              C-right = "move_next_word_start";
            };
          };
        };
      };

      xdg.mimeApps.defaultApplicationPackages = [
        config.programs.helix.package
      ];
    };

  # needed to override default EDITOR
  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/programs/environment.nix
  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };
}
