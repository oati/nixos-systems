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
        ];

        language-server = {
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

    home.packages = with pkgs; [
      nixd
      alejandra
      nixfmt
    ];
  };
}
