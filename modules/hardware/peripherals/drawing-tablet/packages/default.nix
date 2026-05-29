{ ... }:
{
  # remove when opentabletdriver > v0.6.6.2
  nixpkgs.overlays = [
    (final: prev: {
      # nix build .#nixosConfigurations.erin-pc.pkgs.opentabletdriver.fetch-deps
      # ./result modules/hardware/peripherals/drawing-tablet/packages/deps.json
      opentabletdriver = final.callPackage ./opentabletdriver.nix { };
    })
  ];
}
