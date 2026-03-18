{user, ...}: {
  home-manager.users.${user} = {
    programs.nushell = {
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
    };
  };
}
