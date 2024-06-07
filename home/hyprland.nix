{ globals, inputs, pkgs, ... }:
{
  imports = [
    ./swayidle.nix
    ./swaylock.nix
  ];

  environment.systemPackages = with pkgs; [
    hyprland
    hyprpaper
    xdg-utils
    dbus
    qt6Packages.qt6ct
    appimage-run
    dunst
    grimblast
    wl-clipboard
    cliphist
    wl-screenrec
    wdisplays
    brightnessctl
    playerctl
  ];


  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
  };

  home-manager.users."${globals.user}" = {
    imports = [
      inputs.hyprland.homeManagerModules.default
    ];

    home.sessionVariables = {
      # Fix Electron apps on Nixos Wayland
      NIXOS_OZONE_WL = "1";
    };

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style = {
        package = pkgs.kdePackages.breeze;
        name = "breeze-dark";
      };
    };

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Vimix-cursors";
      size = 32;
      package = pkgs.vimix-cursor-theme;
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

    home.file = {
      ".config/hypr/hyprpaper.conf" = {
        source = ./../hypr/hyprpaper.conf;
      };
      /* ".config/hypr/hyprland.conf" = {
        source = ./../hypr/hyprland.conf;
      }; */
      ".config/hypr/autostart.conf" = {
        source = ./../hypr/autostart.conf;
      };
      ".config/hypr/general.conf" = {
        source = ./../hypr/general.conf;
      };
      ".config/hypr/input.conf" = {
        source = ./../hypr/input.conf;
      };
      ".config/hypr/monitor.conf" = {
        source = ./../hypr/monitor.conf;
      };
      ".config/hypr/animation.conf" = {
        source = ./../hypr/animation.conf;
      };
      ".config/hypr/rules.conf" = {
        source = ./../hypr/rules.conf;
      };
      ".config/hypr/binds.conf" = {
        source = ./../hypr/binds.conf;
      };
      ".config/scripts" = {
        source = ./../scripts;
        recursive = true;
      };
    };

    xdg.portal = {
      extraPortals = [ pkgs.inputs.hyprland.xdg-desktop-portal-hyprland ];
      configPackages = [ pkgs.inputs.hyprland.hyprland ];
    };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        source = [
          # "~/.config/hypr/autostart.conf"
          "~/.config/hypr/general.conf"
          "~/.config/hypr/binds.conf"
          "~/.config/hypr/rules.conf"
          "~/.config/hypr/monitor.conf"
          "~/.config/hypr/input.conf"
          "~/.config/hypr/animation.conf"
        ];

        exec-once = [
          "exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE"
          "hyprpaper"
          "dunst"
          "waybar"
          "swayidle -w"
          "hyprctl setcursor Vimix-cursors 32"
        ];

        env = [
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "GDK_BACKEND,wayland"
          "GTK_USE_PORTAL,1"
          "QT_QPA_PLATFORMTHEME,qt6ct"
          "QT_QPA_PLATFORM,wayland"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"
          "MOZ_ENABLE_WAYLAND,1"
          # https://wiki.hyprland.org/Configuring/Tearing/
          "WLR_DRM_NO_ATOMIC,1"
          # "WLR_DRM_DEVICES,/dev/dri/card2:/dev/dri/card1"
        ];

        general = {
          allow_tearing = true;
        };
      };
    };
  };
}

