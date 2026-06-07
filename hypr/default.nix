{
  globals,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./../nix/home/flameshot.nix
  ];

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  environment.systemPackages = with pkgs; [
    # hyprland
    hyprpaper
    hyprlock
    hypridle
    xdg-utils
    qt6Packages.qt6ct
    # xdg-desktop-protocol-hyprland needs this
    # kdePackages.qtwayland
    # libsForQt5.qt5.qtwayland

    # dbus
    appimage-run
    grimblast
    # cliphist
    wl-clipboard
    wl-screenrec
    wdisplays
    # kdePackages.xwaylandvideobridge
    brightnessctl
    pipewire
    wireplumber
    playerctl
  ];

  services.hypridle.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
    # set the flake package
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    # portalPackage =
    #   inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    # wlr.enable = true;
    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
      # Need this for things like opening links, etc.
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      # inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
    ];
  };

  home-manager.users."${globals.user}" = {
    # imports = [
    #   inputs.hyprland.homeManagerModules.default
    # ];

    home.sessionVariables = {
      # Fix Electron apps on Nixos Wayland
      NIXOS_OZONE_WL = "1";
    };

    home.file = {
      ".config/hypr/hyprpaper.conf" = {
        source = ./hyprpaper.conf;
      };
      ".config/hypr/theme.conf" = {
        source = ./theme.conf;
      };
      ".config/hypr/hyprlock.conf" = {
        source = ./hyprlock.conf;
      };
      ".config/hypr/hypridle.conf" = {
        source = ./hypridle.conf;
      };

      /*
        ".config/hypr/hyprland.conf" = {
          source = ./hyprland.conf;
        };
      */
      # ".config/hypr/env.conf" = {
      #   source = ./env.conf;
      # };
      # ".config/hypr/autostart.conf" = {
      #   source = ./autostart.conf;
      # };
      ".config/hypr/general.conf" = {
        source = ./general.conf;
      };
      ".config/hypr/groups.conf" = {
        source = ./groups.conf;
      };
      ".config/hypr/input.conf" = {
        source = ./input.conf;
      };
      ".config/hypr/monitor.conf" = {
        source = ./monitor.conf;
      };
      ".config/hypr/animation.conf" = {
        source = ./animation.conf;
      };
      ".config/hypr/rules.conf" = {
        source = ./rules.conf;
      };
      ".config/hypr/binds.conf" = {
        source = ./binds.conf;
      };
      ".config/scripts" = {
        source = ./../scripts;
        recursive = true;
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      configType = "hyprlang";

      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # portalPackage =
      #   inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

      settings = {
        source = [
          # "~/.config/hypr/autostart.conf"
          # "~/.config/hypr/env.conf"
          "~/.config/hypr/general.conf"
          "~/.config/hypr/groups.conf"
          "~/.config/hypr/binds.conf"
          "~/.config/hypr/rules.conf"
          "~/.config/hypr/monitor.conf"
          "~/.config/hypr/input.conf"
          "~/.config/hypr/animation.conf"
          "~/.config/hypr/theme.conf"
        ];

        exec-once = [
          "wpaperd -d"
          "~/.config/scripts/memory_monitor"
          "eww daemon"
          "eww update laptop_mode=false"
          "hyprctl setcursor Vimix-white-cursors 32"
        ];

        env = [
          # Use iGPU to render Hyprland
          # "WLR_DRM_DEVICES,/dev/dri/card2:/dev/dri/card1"
        ];

        general = {
          allow_tearing = true;
        };
      };
    };
  };
}
