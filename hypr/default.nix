{ globals, inputs, pkgs, ... }:
{
  imports = [
    ./flameshot.nix
  ];

  environment.systemPackages = with pkgs; [
    # hyprland
    hyprpaper
    hyprlock
    hypridle
    xdg-utils
    dbus
    qt6Packages.qt6ct
    qt6.qtwayland
    appimage-run
    dunst
    grimblast
    wl-clipboard
    cliphist
    wl-screenrec
    wdisplays
    xwaylandvideobridge
    brightnessctl
    pipewire
    wireplumber
    playerctl
  ];


  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    # wlr.enable = true;
    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-wlr
      # Need this for things like opening links, etc.
      pkgs.xdg-desktop-portal-gtk
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

    home.file = {
      ".config/hypr/hyprpaper.conf" = {
        source = ./../../hypr/hyprpaper.conf;
      };
      ".config/hypr/theme.conf" = {
        source = ./../../hypr/theme.conf;
      };
      ".config/hypr/hyprlock.conf" = {
        source = ./../../hypr/hyprlock.conf;
      };
      ".config/hypr/hypridle.conf" = {
        source = ./../../hypr/hypridle.conf;
      };

      /* ".config/hypr/hyprland.conf" = {
        source = ./../../hypr/hyprland.conf;
      }; */
      ".config/hypr/autostart.conf" = {
        source = ./../../hypr/autostart.conf;
      };
      ".config/hypr/general.conf" = {
        source = ./../../hypr/general.conf;
      };
      ".config/hypr/input.conf" = {
        source = ./../../hypr/input.conf;
      };
      ".config/hypr/monitor.conf" = {
        source = ./../../hypr/monitor.conf;
      };
      ".config/hypr/animation.conf" = {
        source = ./../../hypr/animation.conf;
      };
      ".config/hypr/rules.conf" = {
        source = ./../../hypr/rules.conf;
      };
      ".config/hypr/binds.conf" = {
        source = ./../../hypr/binds.conf;
      };
      ".config/scripts" = {
        source = ./../../scripts;
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
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE"
          "/usr/lib/polkit-kde-authentication-agent-1"
          "hyprpaper"
          "dunst"
          "eww daemon"
          "eww update laptop_mode=false"
          "waybar"
          "hypridle"
          "hyprctl setcursor Vimix-Cursors-White 32"
        ];

        env = [
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"

          "SDL_VIDEODRIVER,wayland"

          "GDK_BACKEND,wayland"
          "GTK_USE_PORTAL,1"

          "QT_QPA_PLATFORMTHEME,qt6ct"
          "QT_QPA_PLATFORM,wayland"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"

          # Wayland support should be enabled by default
          # "MOZ_ENABLE_WAYLAND,1"

          # https://wiki.hyprland.org/Configuring/Tearing/
          # Not needed for kernel ver >= 6.8
          # but not supported in amdgpu yet
          # https://github.com/hyprwm/Hyprland/issues/5103
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

