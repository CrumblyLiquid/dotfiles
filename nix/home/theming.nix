{ inputs, globals, pkgs, ... }: {
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.inconsolata
    nerd-fonts.inconsolata-go
    nerd-fonts.iosevka
    nerd-fonts.zed-mono
    nerd-fonts.meslo-lg
    nerd-fonts.jetbrains-mono
    nerd-fonts.noto
    font-awesome
    dejavu_fonts
    libertine
  ];

  environment.systemPackages = with pkgs; [
    vimix-cursors
  ];

  environment.sessionVariables = {
    XCURSOR_THEME = "Breeze_Light";
    XCURSOR_SIZE = 32;
  };

  home-manager.users."${globals.user}" = {
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "breeze_cursors";
      size = 32;
      package = pkgs.vimix-cursors;
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
