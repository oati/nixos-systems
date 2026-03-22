{...}: {
  nixpkgs.overlays = [
    (final: prev: {
      nu-lsp = final.callPackage ./nu-lsp.nix {};
    })
  ];
}
