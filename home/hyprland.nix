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
    wlr.enable = true;
    /* extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-wlr
      pkgs.kdePackages.xdg-desktop-portal-kde
    ]; */
  };

  home-manager.users."${globals.user}" = {
    imports = [
      inputs.hyprland.homeManagerModules.default
    ];

    home.sessionVariables = {
      # Fix Electron apps on Nixos Wayland
      NIXOS_OZONE_WL = "1";
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
          "~/.config/hypr/binds.conf"
          "~/.config/hypr/rules.conf"
          "~/.config/hypr/monitor.conf"
          "~/.config/hypr/input.conf"
          "~/.config/hypr/animation.conf"
        ];

        exec-once = [
          "hyprpaper"
          "eww daemon"
          "eww update laptop_mode=false"
          "eww open bar"
          "dunst"
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
          gaps_in = 2;
          gaps_out = 5;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";

          layout = "dwindle";
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
          force_split = 2;
        };

        master = {
          new_is_master = false;
          mfact = 0.5;
        };

        decoration = {
          rounding = 4;
          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            new_optimizations = true;
          };
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          force_default_wallpaper = 0;
        };
      };
    };
  };
}

