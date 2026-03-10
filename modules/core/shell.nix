{
  user,
  pkgs,
  ...
}: {
  users.defaultUserShell = pkgs.bash;
  programs.bash.interactiveShellInit = "exec ${pkgs.nushell}/bin/nu";

  home-manager.users.${user} = {
    programs.nushell = {
      enable = true;

      settings = {
        show_banner = false;
      };

      plugins = [];

      shellAliases = {
        en = "cd /etc/nixos";

        nrs = "run0 nixos-rebuild switch";
        nrb = "run0 nixos-rebuild boot";
        nrt = "run0 nixos-rebuild test";
        nrdb = "run0 nixos-rebuild dry-build";
        nrda = "run0 nixos-rebuild dry-activate";
        nrc = "nixos-rebuild current";

        ngl = "nixos-generations list";
        ngs = "nixos-generations switch";
        ngd = "nixos-generations delete";

        nfu = "nix flake update";
        nfuc = "nix flake update --commit-lock-file";
      };

      extraConfig =
        # nu
        ''
          def "nixos-rebuild current" [] {
            run0 /nix/var/nix/profiles/system/bin/switch-to-configuration test
          }
          def "nixos-generations list" []: nothing -> table {
            nixos-rebuild list-generations --json | from json | update date {into datetime}
          }
          def "nixos-generations switch" [generation: int] {
            run0 nix-env -p /nix/var/nix/profiles/system --switch-generation $generation
          }
          # besides a list of generation numbers to delete, this command can take
          # - +N - delete generations older than the last N generations starting from current
          # - Nd - delete all but the most recent generation older than N days
          # - old - delete all generations except current
          def "nixos-generations delete" [...generations] {
            run0 nix-env -p /nix/var/nix/profiles/system --delete-generations ...$generations
          }
        '';
    };

    home.shell.enableNushellIntegration = true;
  };

  environment.systemPackages = with pkgs; [
    fastfetch

    # network tools
    inetutils
    bind

    # wget
  ];
}
