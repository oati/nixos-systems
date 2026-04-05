{
  name,
  user,
  pkgs,
  ...
}: {
  home-manager.users.${user} = {
    programs.helix = {
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
              nixos.expr =
                "(builtins.getFlake (builtins.toString ./.))"
                + ".nixosConfigurations.${name}.options";
              home-manager.expr =
                "(builtins.getFlake (builtins.toString ./.))"
                + ".nixosConfigurations.${name}.options"
                + ".home-manager.users.type.getSubOptions []";
            };
          };
        };
      };
    };
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

    # yaml
    yaml-language-server
    yamlfmt

    # json
    vscode-json-languageserver

    # css
    vscode-css-languageserver
  ];
}
