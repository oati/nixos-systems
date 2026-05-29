{
  description = "Erin's NixOS Configurations";

  inputs = {
    nixpkgs.url = "github:oati/nixpkgs/fetchcrate-fix";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    intransience = {
      url = "github:anna328p/intransience";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
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

    amoled-cord = {
      url = "github:LuckFire/amoled-cord";
      flake = false;
    };

    iloader = {
      url = "github:nab138/iloader?ref=v2.2.6";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    flakes:
    let
      inherit (flakes.nixpkgs) lib;
      eachSystem = lib.genAttrs lib.systems.flakeExposed;

      genNixosConfigurations = lib.mapAttrs (
        name: modules:
        lib.nixosSystem {
          inherit modules;
          specialArgs = {
            inherit flakes name;
            user = "erin";
          };
        }
      );
    in
    {
      # nixos configurations defined in ./systems.nix
      nixosConfigurations = genNixosConfigurations (
        lib.mergeAttrsList (lib.attrValues (import ./systems.nix))
      );

      # overlays listed in ./overlays.nix
      overlays = lib.mapAttrs (
        name: module:
        lib.composeManyExtensions
          ((import module) {
            # module args
            inherit flakes;
          }).nixpkgs.overlays
      ) (import ./overlays.nix);

      packages = eachSystem (
        system:
        let
          # iso images for all iso systems
          isoConfigurations = genNixosConfigurations (import ./systems.nix).iso;

          isoImages = lib.mapAttrs (
            name: nixosConfiguration: nixosConfiguration.config.system.build.images.iso
          ) isoConfigurations;

          # packages listed in ./packages.nix pulled from overlays
          pkgs = import flakes.nixpkgs {
            localSystem.system = system;
            overlays = lib.attrValues flakes.self.overlays;
          };

          packages = lib.listToAttrs (
            map (name: {
              inherit name;
              value = pkgs.${name};
            }) (import ./packages.nix)
          );
        in
        isoImages // packages
      );
    };
}
