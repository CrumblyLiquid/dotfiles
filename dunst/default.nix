{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dunst
    libnotify
    ntfy-sh
  ];

  services.dunst = {
    enable = true;
  };
}
