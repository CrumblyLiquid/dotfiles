{ globals, pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gamescope
    mangohud
    wineWowPackages.stable
    winetricks
    protontricks
    dxvk
    heroic
    lutris
    protonup-qt
  ];

  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = false;
    # Gamescope fix
    # https://www.reddit.com/r/NixOS/comments/1bmj4mz/gamescope_and_steam/
    # also maybe have to run `sudo chown <username> /tmp/.X11-unix`
    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        libkrb5
        keyutils
      ];
    };
  };

  xdg.portal = {
    enable = true;
    # xdgOpenUsePortal = true;
  };

  # home-manager.users."${globals.user}" = { };
}

