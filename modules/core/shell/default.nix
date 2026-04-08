{
  user,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./aliases.nix
    ./nixos-utils.nix
    ./utils.nix
  ];

  users.defaultUserShell = pkgs.bash;
  programs.bash.interactiveShellInit = "exec ${lib.getExe pkgs.nushell}";

  home-manager.users.${user} = {
    programs.nushell = {
      enable = true;

      # config nu --doc
      settings = {
        show_banner = false;
        history.file_format = "sqlite";

        # default "if (term size).columns >= 100 { table -e } else { table }"
        hooks.display_output = "table";

        # number of rows required to show footer
        footer_mode = 25;

        # truncate last column instead of wrapping
        table.trim = {
          methodology = "truncating";
          truncating_suffix = "...";
        };
      };
    };

    home.shell.enableNushellIntegration = true;

    programs.helix.settings.editor.shell = ["nu" "-c"];

    # completions
    programs.carapace.enable = true;
  };

  environment.variables = {
    PAGER = "moor";
    MOOR = "-terminal-fg";
    # allows systemd commands to use moor
    SYSTEMD_PAGERSECURE = "true";

    # allow unkown flags for completions
    CARAPACE_LENIENT = 1;

    NIXPKGS_ALLOW_UNFREE = 1;
  };

  environment.systemPackages = with pkgs; [
    moor
  ];
}
