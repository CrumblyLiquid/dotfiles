{ globals, inputs, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    hyprland
    hyprpaper
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
      ".config/scripts" = {
        source = ./../scripts;
        recursive = true;
      };
    };

    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings = {
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

      input = {
        kb_layout = "us,cz";
        kb_variant = ",qwerty";
        kb_model = "";
        kb_options = "          # grp:alt_shift_toggle";
        kb_rules = "";

        follow_mouse = 2;

        touchpad = {
          natural_scroll = true;
        };

        sensitivity = 0;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };

      device = {
        name = "logitech-g-pro--1";
        sensitivity = -0.6;
      };

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

      animations = {
        enabled = true;
        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "easeinoutsine, 0.37, 0, 0.63, 1"
        ];
        animation = [
          "windowsIn, 1, 3, easeOutCubic, popin 30%           # window open"
          "windowsOut, 1, 3, fluent_decel, popin 70%           # window close"
          "windowsMove, 1, 2, easeinoutsine, slide           # everything in between, moving, dragging, resizing"
          "fadeIn, 1, 3, easeOutCubic            # fade in (open) -> layers and windows"
          "fadeOut, 1, 1.7, easeOutCubic           # fade out (close) -> layers and windows"
          "fadeSwitch, 0, 1, easeOutCirc           # fade on changing activewindow and its opacity"
          "fadeShadow, 1, 10, easeOutCirc           # fade on changing activewindow for shadows"
          "fadeDim, 1, 4, fluent_decel           # the easing of the dimming of inactive windows"
          "border, 1, 2.7, easeOutCirc           # for animating the border's color switch speed"
          "borderangle, 1, 30, fluent_decel, once           # for animating the border's gradient angle - styles: once (default), loop"
          # "workspaces, 1, 3, easeOutCubic, fade # styles: slide, slidevert, fade, slidefade, slidefadevert"
        ];
      };

      windowrulev2 = [
        "immediate, class:^(cs2)$"
        "immediate, title:^(osu!)$"
        "immediate, title:^(Hollow Knight)$"
        # Steam windows losing focus fix
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
      ];

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
      };

      "$mainMod" = "ALT";

      bind = [
        "$mainMod, Q, exec, kitty"
        "$mainMod, W, exec, firefox"
        "$mainMod, E, exec, dolphin"
        "$mainMod, R, exec, tofi-drun --drun-launch=true"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, T, exec, hyprctl reload"
        "$mainMod, semicolon, togglefloating, "
        "$mainMod, F, fullscreen, "

        # Application binds
        "$mainMod, D, exec, discord"

        # dwindle
        "$mainMod, P, pseudo,"
        "$mainMod, O, togglesplit,"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Move focus with mainMod + vim keys
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Move active window with mainMod + Shift + arrow keys
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

        # Move active window with mainMod + Shift + vim keys
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_up, workspace, e+1"
        "$mainMod, mouse_down, workspace, e-1"


        # Switch keyboard layout
        "CONTROL ALT, K, exec, hyprctl switchxkblayout at-translated-set-2-keyboard next"
        "CONTROL ALT, K, exec, hyprctl switchxkblayout keychron-keychron-k8-pro-keyboard next"

        # Volume controls
        " , XF86AudioMute,        exec, .config/scripts/volume out mute"
        " , XF86AudioMicMute,     exec, .config/scripts/volume in mute"

        # Brightness
        ", XF86MonBrightnessUp,   exec, .config/scripts/brightness up 5"
        ", XF86MonBrightnessDown, exec, .config/scripts/brightness down 5"

        # Music player
        ", XF86AudioPrev, exec, .config/scripts/music previous"
        ", XF86AudioNext, exec, .config/scripts/music next"
        ", XF86AudioPlay, exec, .config/scripts/music play"

        # Lock screen
        "SUPER, L, exec, swaylock -f -C ~/.config/sway-lock/config"

        "           , Print, exec, grimblast copy active"
        "SUPER SHIFT, Print, exec, grimblast copy area"

        # Caps Lock OSD
        ", Caps_Lock, exec, ~/.config/eww/scripts/caps-osd"

        # Save replay
        # bind = $mainMod SHIFT, R, exec, .config/scripts/save_replay
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        # Volume controls
        ", XF86AudioRaiseVolume, exec, .config/scripts/volume out up"
        ", XF86AudioLowerVolume, exec, .config/scripts/volume out down"
        "SHIFT, XF86AudioRaiseVolume, exec, .config/scripts/volume in up"
        "SHIFT, XF86AudioLowerVolume, exec, .config/scripts/volume in down"
        "SHIFT, XF86AudioMute,        exec, .config/scripts/volume in mute"
      ];
    };
  };
}

