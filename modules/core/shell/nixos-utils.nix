{ user, ... }:
{
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
            let generations_list: table = nixos-generations list
            let generations: list<int> = $indices | each { |item|
              match ($item | describe) {
                "int" => {
                  $generations_list | select $item
                }
                "range" => {
                  $generations_list | slice $item
                }
              }
            } | flatten | where not current | get generation

            if ($generations | is-not-empty) {
              run0 nix-env -p /nix/var/nix/profiles/system --delete-generations ...$generations
            }

            let boot_entries = run0 find /boot/loader/entries/ | lines
              | where (str ends-with '.conf')
              | where (path basename | str starts-with 'nixos-')
              | where {
                let gen: int = run0 cat $in | lines
                  | parse --regex '^version Generation (\d+)' | first
                  | get capture0 | into int
                $gen in $generations
              }

            run0 rm ...$boot_entries
          }

          # delete all generations except current
          def "nixos-generations delete all" [] {
            nixos-generations delete 0..
          }
        '';
    };
  };
}
