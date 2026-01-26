{ globals, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dunst
    libnotify
    ntfy-sh
  ];

  /*
    home-manager.users."${globals.user}" = {
      home.file = {
        ".config/dunst" = {
          source = ./.;
          recursive = true;
        };
      };
    };
  */
}
