{ config, lib, pkgs, inputs, globals, ... }:

{
  imports =
    [
      inputs.home-manager.nixosModules.default
      ./../../default.nix # default.nix - Default system configuration
      ./hardware-configuration.nix
      ./../../home
    ];

  networking.hostName = "solid";

  home-manager = {
    users."${globals.user}" = {
      programs.ssh = {
        enable = true;
        extraConfig = builtins.readFile ./../../ssh/config;
      };

      home = {
        username = "crumbly";
        homeDirectory = "/home/crumbly";

        stateVersion = "23.11";
      };
    };
  };


  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  system.stateVersion = "23.11"; # Did you read the comment?
}

