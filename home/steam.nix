{ globals, pkgs, ... }: {
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  xdg.portal = {
    enable = true;
    # xdgOpenUsePortal = true;
  };

  # home-manager.users."${globals.user}" = { };
}

