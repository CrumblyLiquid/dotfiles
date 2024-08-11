{ inputs, globals, pkgs, ... }: {
  home-manager.users."${globals.user}" = {
    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style = {
        package = pkgs.kdePackages.breeze;
        name = "breeze-dark";
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Breeze-Dark";
        package = pkgs.kdePackages.breeze-gtk;
      };
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
      font = {
        name = "Sans";
        size = 12;
      };
    };

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Vimix-cursors";
      size = 32;
      package = pkgs.vimix-cursor-theme;
    };
  };
}
