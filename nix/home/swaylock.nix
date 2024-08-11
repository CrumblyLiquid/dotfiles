{ globals, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    swaylock-effects
  ];

  # https://nixos.wiki/wiki/Sway#Swaylock_cannot_be_unlocked_with_the_correct_password
  security.pam.services.swaylock = {};

  home-manager.users."${globals.user}" = {
    home.file = {
      ".config/sway-lock/config" = {
        source = ./../../swaylock/config;
      };
    };
  };
}

