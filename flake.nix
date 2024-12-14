{
  description = "NixOS Configuration with multiple device profiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        # Steam Deck configuration
        "steam-deck" = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/steam-deck
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.cizen = import ./home;
            }
          ];
        };
        
        # Laptop configuration
        "laptop" = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/laptop
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.cizen = import ./home;
            }
          ];
        };
      };
    };
}
