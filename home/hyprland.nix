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
    dunst
    grimblast
    wl-clipboard
    wdisplays
    brightnessctl
    playerctl
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  home-manager.users."${globals.user}" = {
    imports = [
      inputs.hyprland.homeManagerModules.default
    ];

    home.file = {
      ".config/hypr/hyprpaper.conf" = {
        text = ''
          preload = ${globals.wallpaper}
          wallpaper = ,${globals.wallpaper}
          splash = false
        '';
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

    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings = {
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
        # "hyprctl setcursor {{cursor}} {{cursor_size}}";
      ];

      env = [
        "XCURSOR_SIZE,32"
        "QT_QPA_PLATFORM,wayland"
        "QT_QPA_PLATFORMTHEME,qt6ct"
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
}

