{ globals, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    waybar
    pavucontrol
  ];

  home-manager.users."${globals.user}" = {
    services.status-notifier-watcher.enable = true;
    home.file = {
      ".config/waybar" = {
        source = ./../../waybar;
        recursive = true;
      };
    };
  };
}

