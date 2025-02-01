{ inputs, globals, pkgs, ... }: {
  imports = let base = ./../..; in [
    inputs.home-manager.nixosModules.default
    ./theming.nix

    ./sound.nix
    ./keyboard.nix
    ./bluetooth.nix
    ./dev.nix
    ./android.nix

    # Applications
    ./flatpak.nix
    ./apps.nix
    ./gaming.nix
    # ./fun.nix
    ./firefox.nix
    ./obs.nix
    ./spotify.nix
    (base + /opentabletdriver)
    (base + /xournalpp)
    # Disabled because gns3 gui doesn't support Python 3.12
    ./gns3.nix
    ./wireshark.nix
    ./virtmanager.nix
    ./syncthing.nix

    # Terminal
    ./terminal.nix
    (base + /kitty)
    (base + /zsh)
    (base + /starship)
    (base + /nvim)
    (base + /tmux)

    # Window Manager
    (base + /hypr)
    (base + /tofi)
    (base + /eww)
    (base + /dunst)
    # (base + /swayidle)
    # (base + /swaylock)
    (base + /waybar)

    (base + /kde)
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  home-manager.users."${globals.user}" = {
    xdg.enable = true;
    xdg.configFile."wallpaper.png" = { source = globals.wallpaper; };
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "image/png" = "gwenview.desktop";
        "image/svg+xml" = "gwenview.desktop";
        "image/jpeg" = "gwenview.desktop";
        "image/webp" = "gwenview.desktop";
        "image/gif" = "gwenview.desktop";
        "image/avif" = "gwenview.desktop";
        "image/tiff" = "gwenview.desktop";
        "image/bmp" = "gwenview.desktop";
        "image/x-icon" = "gwenview.desktop";
        "audio/mp4" = "vlc.desktop";
        "video/mp4" = "vlc.desktop";
        "audio/mp3" = "vlc.desktop";
        "inode/directory" = "dolphin.desktop";
        "application/pdf" = "okular.desktop";
        "application/zip" = "ark.desktop";
        "application/tar" = "ark.desktop";
        "application/gz" = "ark.desktop";
        "text/plain" = "kate.desktop";
        "text/csv" = "kate.desktop";
        "text/html" = "kate.desktop";
        "text/xml" = "kate.desktop";
      };
    };

    home.packages = with pkgs; [ ];
    home.file = { };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };

}
