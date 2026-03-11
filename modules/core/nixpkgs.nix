{flakes, ...}: {
  nixpkgs = {
    overlays = [
      (
        final: prev: let
          packages = flake: flake.packages.${prev.stdenv.hostPlatform.system};
        in {
          inherit (packages flakes.home-manager) home-manager;
          inherit (packages flakes.disko) disko;
          nix-index = (packages flakes.nix-index-database).nix-index-with-db;
        }
      )
    ];

    config = {
      allowUnfree = true;
    };
  };
}
