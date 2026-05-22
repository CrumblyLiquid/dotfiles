{ globals, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    jq
    socat
    eww
  ];
}
