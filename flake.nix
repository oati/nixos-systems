{
  description = "Erin's NixOS Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    intransience = {
      url = "github:anna328p/intransience";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };

    delta-shell = {
      url = "github:oati/delta-shell/flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    amoled-cord = {
      url = "github:LuckFire/amoled-cord";
      flake = false;
    };
  };

  outputs = flakes: {
    nixosConfigurations = builtins.mapAttrs (
      name: modules:
        flakes.nixpkgs.lib.nixosSystem {
          inherit modules;
          specialArgs = {
            inherit flakes;
            user = "erin";
          };
        }
    ) (import ./systems.nix);
  };
}
