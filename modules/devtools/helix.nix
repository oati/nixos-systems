{
  user,
  pkgs,
  config,
  ...
}: {
  home-manager.users.${user} = {
    programs.helix = {
      enable = true;

      settings = {
        theme = "modus_vivendi"; # catppuccin_frappe darcula dracula nord dark_plus github_dark_dimmed zed_onedark

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

      languages = {
        language = [
          {
            name = "nix";
            language-servers = ["nixd"];
            formatter = {
              command = "alejandra";
            };
            auto-format = true;
          }
        ];

        language-server = {
          nixd = {
            nixpkgs.expr = "import (builtins.getFlake (builtins.toString ./.)).inputs.nixpkgs {}";
            options = {
              nixos.expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${config.networking.hostName}.options";
              home-manager.expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${config.networking.hostName}.options.home-manager.users.type.getSubOptions []";
            };
          };
        };
      };
    };

    programs.nushell.settings.buffer_editor = "hx";

    home.sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };
  };

  environment.systemPackages = with pkgs; [
    # nix
    nixd
    alejandra
  ];
}
