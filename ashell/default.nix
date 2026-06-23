{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ashell
    upower
  ];
}
