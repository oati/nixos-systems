{
  user,
  lib,
  pkgs,
  ...
}: {
  users.defaultUserShell = pkgs.bash;
  programs.bash.interactiveShellInit = "exec ${lib.getExe pkgs.nushell}";

  home-manager.users.${user} = {
    programs.nushell = {
      enable = true;

      settings = {
        show_banner = false;
      };

      plugins = [];

      shellAliases = {
        en = "cd /etc/nixos";

        nrs = "nixos-rebuild switch --sudo --no-reexec";
        nrb = "nixos-rebuild boot --sudo --no-reexec";
        nrt = "nixos-rebuild test --sudo --no-reexec";
        nrdb = "nixos-rebuild dry-build --sudo --no-reexec";
        nrda = "nixos-rebuild dry-activate --sudo --no-reexec";
        nrac = "nixos-rebuild activate-current --sudo";

        ngl = "nixos-generations list";
        ngs = "nixos-generations switch";
        ngd = "nixos-generations delete";

        nfu = "nix flake update";
        nfuc = "nix flake update --commit-lock-file";
      };

      extraConfig =
        # nu
        ''
          def "nixos-rebuild activate-current" [--sudo] {
            if $sudo {
              run0 /nix/var/nix/profiles/system/bin/switch-to-configuration test
            } else {
              /nix/var/nix/profiles/system/bin/switch-to-configuration test
            }
          }
          def "nixos-generations list" []: nothing -> table {
            nixos-rebuild list-generations --json | from json
              | update date {into datetime}
              | rename --column {configurationRevision: revision}
              | move current --after generation
              | move revision --after date
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

  environment.variables = {
    PAGER = "moor";
    # allows systemd commands to use moor
    SYSTEMD_PAGERSECURE = "true";
  };

  environment.systemPackages = with pkgs; [
    fastfetch

    # shell utils
    moor
    ripgrep
    inotify-tools

    wget
  ];
}
