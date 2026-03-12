{
  description = "Erin's NixOS Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";

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
