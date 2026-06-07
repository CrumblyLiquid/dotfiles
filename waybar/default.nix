{ globals, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    waybar
    pavucontrol
  ];

  home-manager.users."${globals.user}" = {
    services.status-notifier-watcher.enable = true;
    /*
      home.file = {
        ".config/waybar" = {
          source = ./.;
          recursive = true;
        };
      };
    */

    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };
  };
}
