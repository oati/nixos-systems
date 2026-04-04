{...}: {
  nixpkgs.overlays = [
    # remove when > v1.0.1 and not broken in nixpkgs
    (final: prev: {
      pythonPackagesExtensions =
        prev.pythonPackagesExtensions
        ++ [
          (pfinal: pprev: {
            opentype-feature-freezer =
              pfinal.callPackage ./opentype-feature-freezer.nix {};
          })
        ];
    })
  ];
}
