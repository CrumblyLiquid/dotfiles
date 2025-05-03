{
  description = "CrumblyLiquid's System Wide Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    musnix = { url = "github:musnix/musnix"; };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      globals = rec {
        user = "crumbly";
        homePath = "/home/${user}";
        system = "x86_64-linux";
        wallpaper = ./wallpapers/flow.png;
      };
    in
    {
      nixosConfigurations = {
        solid = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs globals;
          };
          modules = [ ./nix-solid ];
        };
        /*
          liquid = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs globals;
            };
            modules = [ ./nix-liquid ];
          };
        */
      };
    };
}
