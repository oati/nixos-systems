{ ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      sabaki = final.callPackage ./sabaki.nix { };
    })
  ];
}
