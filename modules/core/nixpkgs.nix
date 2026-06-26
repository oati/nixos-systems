{ flakes, ... }:
{
  nixpkgs = {
    overlays = [
      flakes.nur.overlays.default
      (
        final: prev:
        let
          packages = flake: flake.packages.${final.stdenv.hostPlatform.system};
        in
        {
          inherit (packages flakes.determinate-nix) nix;
          inherit (packages flakes.disko) disko;
          inherit (packages flakes.home-manager) home-manager;
          inherit (packages flakes.helix) helix;
          inherit (packages flakes.delta-shell) delta-shell;
          inherit (packages flakes.iloader) iloader;
          nix-index = (packages flakes.nix-index-database).nix-index-with-db;
        }
      )
    ];

    config = {
      allowUnfree = true;
    };
  };
}
