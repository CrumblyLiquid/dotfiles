{ globals, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gamescope
    mangohud
    wineWowPackages.stable
    winetricks
    protontricks
    dxvk
  ];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = false;
  };

  xdg.portal = {
    enable = true;
    # xdgOpenUsePortal = true;
  };

  # home-manager.users."${globals.user}" = { };
}

