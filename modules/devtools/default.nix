{ ... }:
{
  imports = [
    ./packages
    ./helix.nix
    ./version-control
    ./nix-tools.nix
    ./languages
    ./embedded.nix
  ];
}
