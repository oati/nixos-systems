{ user, ... }:
{
  home-manager.users.${user} = {
    programs.nushell = {
      shellAliases = {
        en = "cd /etc/nixos";

        ngl = "nixos-generations list";
        ngs = "nixos-generations switch";
        ngd = "nixos-generations delete";
        ngi = "nixos-generations diff";

        nfu = "nix flake update";
        nfuc = "nix flake update-follow --commit-lock-file";
        nfuca = "nix flake update --commit-lock-file";
      };
    };
  };
}
