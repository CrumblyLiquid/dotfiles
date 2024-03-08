{ config, pkgs, ... }:
{
  programs.plasma = {
    workspace = {
      them = "breeze-dark";
      colorScheme = "BreezeDark";
    };
  };
}

