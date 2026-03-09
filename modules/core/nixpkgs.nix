{flakes, ...}: {
  nixpkgs = {
    overlays = [
      (
        final: prev: let
          packages = flake: flake.packages.${prev.stdenv.hostPlatform.system};
        in {
          inherit (packages flakes.home-manager) home-manager;
          inherit (packages flakes.disko) disko;
        }
      )
    ];

    config = {
      allowUnfree = true;
    };
  };
}
