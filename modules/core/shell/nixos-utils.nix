{user, ...}: {
  programs.nh = {
    enable = true;
  };

  home-manager.users.${user} = {
    programs.nushell = {
      extraConfig =
        # nu
        ''
          # activate the boot default configuration
          def "nh os restore" [] {
            run0 /nix/var/nix/profiles/system/bin/switch-to-configuration test
          }

          # list nixos generations
          def "nixos-generations list" []: nothing -> table {
            nixos-rebuild list-generations --json | from json
              | update date {into datetime}
              | rename --column {
                configurationRevision: revision
                nixosVersion: version
                kernelVersion: kernel
              }
              | move current --after generation
              | move revision --after date
          }

          # switch to a generation by index from nixos-generations list
          def "nixos-generations switch" [index: int] {
            let generation: int = nixos-generations list | get $index | get generation

            run0 nix-env -p /nix/var/nix/profiles/system --switch-generation $generation
          }

          # delete generations by indices
          def "nixos-generations delete" [...indices: oneof<int, range>] {
            let generations_list: list<int> = nixos-generations list | get generation
            let generations: list<int> = $indices | each {|item|
              match ($item | describe) {
                "int" => {
                  $generations_list | select $item
                }
                "range" => {
                  $generations_list | slice $item
                }
              }
            } | flatten

            run0 nix-env -p /nix/var/nix/profiles/system --delete-generations ...$generations
          }

          # delete all generations except current
          def "nixos-generations delete all" [] {
            run0 nix-env -p /nix/var/nix/profiles/system --delete-generations old
          }
        '';
    };
  };
}
