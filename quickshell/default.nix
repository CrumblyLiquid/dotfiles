{ globals, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    quickshell
  ];
}
