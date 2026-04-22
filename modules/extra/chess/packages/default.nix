{...}: {
  nixpkgs.overlays = [
    (final: prev: {
      nibbler = final.callPackage ./nibbler.nix {};
    })
  ];
}
