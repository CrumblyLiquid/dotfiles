{ globals, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gamescope
    mangohud
    wineWow64Packages.stable
    winetricks
    protontricks
    dxvk
    # Failing to build Electron: https://github.com/NixOS/nixpkgs/issues/370014
    # heroic
    # lutris
    protonup-qt
  ];

  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = false;
    # Gamescope fix
    # https://www.reddit.com/r/NixOS/comments/1bmj4mz/gamescope_and_steam/
    # also maybe have to run `sudo chown <username> /tmp/.X11-unix`
    package = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          libkrb5
          keyutils
        ];
    };
  };

  xdg.portal = {
    enable = true;
    # xdgOpenUsePortal = true;
  };

  # https://gist.github.com/ammuench/0dcf14faf4e3b000020992612a2711e2
  services.udev = {
    # ACTION=="add", ATTRS{idVendor}=="2dc8", ATTRS{idProduct}=="310a", RUN+="/sbin/modprobe xpad", RUN+="/bin/sh -c 'echo 2dc8 310a > /sys/bus/usb/drivers/xpad/new_id'"
    # ACTION=="add", ATTRS{idVendor}=="2dc8", ATTRS{idProduct}=="310a", MODE="0666"
    extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idProduct}=="310a", ATTRS{idVendor}=="2dc8", MODE="0666", TAG+="uaccess", TAG+="udev-acl"
    '';
  };

  # home-manager.users."${globals.user}" = { };
}
