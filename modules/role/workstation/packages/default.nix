{...}: {
  nixpkgs.overlays = [
    # remove when > v1.0.1 and not broken in nixpkgs
    (final: prev: {
      pythonPackagesExtensions =
        prev.pythonPackagesExtensions
        ++ [
          (pfinal: pprev: {
            opentype-feature-freezer = pprev.opentype-feature-freezer.overridePythonAttrs (old: {
              src = final.fetchFromGitHub {
                owner = "oati";
                repo = "fonttools-opentype-feature-freezer";
                rev = "68d19ad6f02c02cf989bf9063bffafab0c5ca4cb";
                hash = "sha256-Iupsi00K6D8Gcvw0AC47wwYUiCGnUlVhe5gFpe7uV98=";
              };
            });
          })
        ];
    })
  ];
}
