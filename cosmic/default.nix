{ globals, inputs, pkgs, ... }:
{
  imports = [
    # https://github.com/lilyinstarlight/nixos-cosmic
    inputs.nixos-cosmic.nixosModules.default
  ];

  services.desktopManager.cosmic.enable = true;

  environment.systemPackages = with pkgs; [
  ];
}

