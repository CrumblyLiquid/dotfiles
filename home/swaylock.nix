{ globals, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    swaylock-effects
  ];

  home-manager.users."${globals.user}" = {
    home.file = {
      ".config/sway-lock/config" = {
        source = ./../swaylock/config;
      };
    };
  };
}

