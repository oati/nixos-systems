{user, ...}: {
  programs.nh = {
    enable = true;
  };

  home-manager.users.${user} = {
    programs.nushell = {
      extraConfig =
        # nu
        ''
          # Activate the boot default configuration
          def "nh os restore" [] {
            run0 /nix/var/nix/profiles/system/bin/switch-to-configuration test
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

          # Besides a list of generation numbers to delete, this command can take
          # - +N - delete generations older than the last N generations starting from current
          # - Nd - delete all but the most recent generation older than N days
          # - old - delete all generations except current
          def "nixos-generations delete" [...generations] {
            run0 nix-env -p /nix/var/nix/profiles/system --delete-generations ...$generations
          }
        '';
    };
  };
}
