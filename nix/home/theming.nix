{
  globals,
  pkgs,
  ...
}:
{
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.inconsolata
    # nerd-fonts.inconsolata-go
    nerd-fonts.iosevka
    nerd-fonts.zed-mono
    nerd-fonts.meslo-lg
    nerd-fonts.jetbrains-mono
    nerd-fonts.noto
    nerd-fonts.liberation
    # liberation_ttf
    font-awesome
    dejavu_fonts
    libertine
    corefonts
    inter
    # tex-gyre
    # tex-gyre-math
  ];

  # https://nixos.wiki/wiki/Fonts#Flatpak_applications_can't_find_system_fonts
  # Create font directory so
  # Flatpak apps can access system fonts
  fonts.fontDir.enable = true;

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
      name = "Breeze_Light";
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
