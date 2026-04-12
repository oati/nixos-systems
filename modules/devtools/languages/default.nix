{
  user,
  pkgs,
  ...
}: {
  imports = [
    ./nix.nix
    ./rust.nix
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

    home.packages = with pkgs; [
      # color codes
      uwu-colors

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

      # nushell
      nu-lsp
      nufmt

      # bash
      bash-language-server
      shfmt
    ];
  };
}
