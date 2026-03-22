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
            language-servers = ["nixd" "uwu-colors"];
            formatter = {
              command = "alejandra";
            };
            auto-format = true;
          }
          {
            name = "nu";
            # remove when helix > 25.07.1
            formatter = {
              command = "nufmt";
              args = ["--stdin"];
            };
            auto-format = true;
          }
          {
            name = "toml";
            auto-format = true;
          }
          {
            name = "css";
            language-servers = ["vscode-css-language-server" "uwu-colors"];
          }
        ];

        language-server = {
          uwu-colors.command = "uwu_colors";

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
  };

  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  environment.systemPackages = with pkgs; [
    # color codes
    uwu-colors

    # nix
    nixd
    alejandra

    # nushell
    nu-lsp
    nufmt

    # bash
    bash-language-server
    shfmt

    # markdown
    marksman

    # toml
    tombi

    vscode-json-languageserver
    vscode-css-languageserver
  ];
}
