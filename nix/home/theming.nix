{ inputs, globals, pkgs, ... }: {
  fonts.packages = with pkgs; [
    nerdfonts
    meslo-lgs-nf
    noto-fonts
    noto-fonts-emoji
    font-awesome
    dejavu_fonts
    libertine
  ];

  environment.systemPackages = with pkgs; [
    vimix-cursor-theme
  ];

  environment.sessionVariables = {
    XCURSOR_THEME = "Vimix-Cursors-White";
    XCURSOR_SIZE = 32;
  };

  home-manager.users."${globals.user}" = {
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Vimix-Cursors-White";
      size = 32;
      package = pkgs.vimix-cursor-theme;
    };

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

  };
}
