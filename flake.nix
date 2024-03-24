{
  description = "CrumblyLiquid's System Wide Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    # plasma-manager.url = "github:pjones/plasma-manager";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      globals = rec {
        user = "crumbly";
        homePath = "/home/${user}";
        system = "x86_64-linux";
        wallpaper = ./wallpapers/dolphin.jpg;
      };
    in
    {
      nixosConfigurations = {
        solid = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs globals;
          };
          modules = [ ./hosts/solid ];
        };
        /*
          liquid = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/liquid ];
          };
        */
      };
    };
}
