{
  user,
  lib,
  config,
  ...
}:
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

          keys =
            let
              disable-hjkl = lib.genAttrs [ "h" "j" "k" "l" ] (n: "no_op");

              window = {
                C-up = "swap_view_up";
                C-down = "swap_view_down";
                C-left = "swap_view_left";
                C-right = "swap_view_right";
              }
              // disable-hjkl
              // lib.genAttrs [ "H" "J" "K" "L" ] (n: "no_op")
              // lib.genAttrs [ "C-h" "C-j" "C-k" "C-l" ] (n: "no_op");
            in
            {
              normal = {
                C-w = window;
                space.w = window;

                g = {
                  up = "move_line_up";
                  down = "move_line_down";
                }
                // disable-hjkl;
              }
              // disable-hjkl;

              select = {
                C-w = window;
                space.w = window;

                g = {
                  up = "extend_line_up";
                  down = "extend_line_down";
                }
                // disable-hjkl;
              }
              // disable-hjkl;

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

  environment.systemPackages = [
    config.home-manager.users.${user}.programs.helix.package
  ];

  # needed to override default EDITOR
  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/programs/environment.nix
  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };
}
