{ globals, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    xournalpp
    # Fix crashes
    gnome.adwaita-icon-theme
  ];

  home-manager.users."${globals.user}" = {
    home.file = {
      ".config/xournalpp" = {
        source = ./../xournalpp;
        recursive = true;
      };
    };
  };
}

