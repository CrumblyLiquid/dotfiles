{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    hyprpaper
    hyprlock
    hypridle
    xdg-utils
    qt6Packages.qt6ct

    appimage-run
    grimblast
    wl-clipboard
    wl-screenrec
    wdisplays
    brightnessctl
    pipewire
    wireplumber
    playerctl

    networkmanagerapplet
    blueman
    libappindicator-gtk3
  ];

  services.hypridle.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      # Need this for things like opening links, etc.
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
