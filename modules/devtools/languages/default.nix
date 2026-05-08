{
  user,
  pkgs,
  ...
}: {
  imports = [
    ./nix.nix
    ./rust.nix
    ./python.nix
    ./typst.nix
  ];

  home-manager.users.${user} = {
    programs.helix = {
      languages = {
        language = [
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
          # color codes
          uwu-colors.command = "uwu_colors";
        };
      };
    };

    home.packages = [
      # color codes
      pkgs.uwu-colors

      # markdown
      pkgs.marksman

      # toml
      pkgs.tombi

      # yaml
      pkgs.yaml-language-server
      pkgs.yamlfmt

      # json
      pkgs.vscode-json-languageserver

      # css
      pkgs.vscode-css-languageserver

      # nushell
      pkgs.nu-lsp
      pkgs.nufmt

      # bash
      pkgs.bash-language-server
      pkgs.shfmt
    ];
  };
}
