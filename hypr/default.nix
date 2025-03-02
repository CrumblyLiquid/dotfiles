{ globals, inputs, pkgs, ... }:
{
  imports = [
    ./../nix/home/flameshot.nix
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
    # cliphist
    wl-screenrec
    wdisplays
    kdePackages.xwaylandvideobridge
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

      /* ".config/hypr/hyprland.conf" = {
        source = ./hyprland.conf;
      }; */
      ".config/hypr/env.conf" = {
        source = ./env.conf;
      };
      ".config/hypr/autostart.conf" = {
        source = ./autostart.conf;
      };
      ".config/hypr/general.conf" = {
        source = ./general.conf;
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

      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

      settings = {
        source = [
          # "~/.config/hypr/autostart.conf"
          "~/.config/hypr/env.conf"
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
          # Wayland support should be enabled by default
          # "MOZ_ENABLE_WAYLAND,1"

          # https://wiki.hyprland.org/Configuring/Tearing/
          # Not needed for kernel ver >= 6.8
          # -- but not supported in amdgpu yet --
          # might be finally supported so this is not needed anymore
          # https://github.com/hyprwm/Hyprland/issues/5103
          # "WLR_DRM_NO_ATOMIC,1"

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

