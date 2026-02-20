{ globals, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mullvad
    mullvad-vpn
    mullvad-compass
  ];

  services.mullvad-vpn.enable = true;
}
