{user, ...}: {
  imports = [
    ./languages.nix
  ];

  home-manager.users.${user} = {
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
  };

  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };
}
