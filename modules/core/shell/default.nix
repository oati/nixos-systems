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

      settings = {
        show_banner = false;

        history.file_format = "sqlite";
      };
    };

    home.shell.enableNushellIntegration = true;

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
