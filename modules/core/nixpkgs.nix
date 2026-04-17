{flakes, ...}: {
  nixpkgs = {
    overlays = [
      flakes.nur.overlays.default
      (
        final: prev: let
          packages = flake: flake.packages.${prev.stdenv.hostPlatform.system};
        in {
          inherit (packages flakes.home-manager) home-manager;
          inherit (packages flakes.disko) disko;
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
