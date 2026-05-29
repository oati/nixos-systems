{ user, ... }:
{
  home-manager.users.${user} = {
    programs.nushell = {
      shellAliases = {
        en = "cd /etc/nixos";

        ngl = "nixos-generations list";
        ngs = "nixos-generations switch";
        ngd = "nixos-generations delete";

        nfu = "nix flake update";
        nfuc = "nix flake update --commit-lock-file";
      };
    };
  };
}
