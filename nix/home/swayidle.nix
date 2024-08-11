{ globals, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    swayidle
    sway-audio-idle-inhibit
  ];

  home-manager.users."${globals.user}" = {
    home.file = {
      ".config/swayidle/config" = {
        source = ./../../swayidle/config;
      };
    };
  };
}

