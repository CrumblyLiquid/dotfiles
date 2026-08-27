{
  config,
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
    font-awesome_6
    dejavu_fonts
    libertine
    # corefonts
    inter
    cascadia-code
    # noto-fonts
    cm_unicode
    texlivePackages.cm-unicode
    # tex-gyre
    # tex-gyre-math
  ];

  # https://nixos.wiki/wiki/Fonts#Flatpak_applications_can't_find_system_fonts
  # Create font directory so
  # Flatpak apps can access system fonts
  fonts.fontDir.enable = true;

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "JetBrainsMono Nerd Font"
        "Font Awesome 6 Free"
        "Font Awesome 6 Brands"
        "DejaVu Sans Mono"
      ];
      sansSerif = [
        "Inter"
        "DejaVu Sans"
      ];
      serif = [ "DejaVu Serif" ];
    };
  };

  environment.systemPackages = with pkgs; [
    vimix-cursors
  ];

  home-manager.users."${globals.user}" = {
    home.pointerCursor = {
      enable = true;
      size = 32;
      name = "Vimix-cursors";
      package = pkgs.vimix-cursors;

      gtk.enable = true;
      x11.enable = true;
    };

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style = {
        package = pkgs.kdePackages.breeze;
        name = "Breeze";
      };
    };

    gtk = rec {
      enable = true;

      theme = {
        name = "Breeze-Dark";
        package = pkgs.kdePackages.breeze-gtk;
      };

      gtk4.theme = theme;

      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };

      font = {
        name = "Inter";
        size = 12;
      };
    };

  };
}
