{ globals, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dunst
  ];

  home-manager.users."${globals.user}" = {
    home.file = {
      ".config/dunst" = {
        source = ./../dunst;
        recursive = true;
      };
    };
  };
}

