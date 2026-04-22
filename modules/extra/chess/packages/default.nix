{...}: {
  nixpkgs.overlays = [
    (final: prev: {
      nibbler = final.callPackage ./nibbler.nix {};

      lc0 = final.callPackage ./lc0.nix {};
    })
  ];
}
