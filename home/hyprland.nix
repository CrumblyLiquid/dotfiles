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
      ".config/hypr" = {
        source = ./../hypr;
        recursive = true;
      };
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
      ".config/scripts" = {
        source = ./../scripts;
        recursive = true;
      };
      ".config/sway-lock/config" = {
        source = ./../swaylock/config;
        recursive = true;
      };
      ".config/sway-lock/config" = {
        source = ./../swaylock/config;
        recursive = true;
      };
    };

    wayland.windowManager.hyprland.enable = true;
  };
}

