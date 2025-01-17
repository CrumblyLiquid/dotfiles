{ globals, pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    thunderbird

    vlc
    mpv

    keepassxc
    audacity
    # lmms

    kdePackages.dolphin
    kdePackages.dolphin-plugins
    # From https://wiki.nixos.org/wiki/Dolphin
    # For wayland support
    kdePackages.qtwayland
    # For correct svg icons rendering
    kdePackages.qtsvg
    # Mounting network shares
    kdePackages.kio-fuse
    kdePackages.kio-extras
    # Fix file associations
    kdePackages.plasma-workspace

    kdePackages.ark
    kdePackages.karchive
    kdePackages.kate
    kdePackages.filelight
    kdePackages.gwenview
    kdePackages.bluez-qt

    kdePackages.breeze
    kdePackages.breeze-gtk
    kdePackages.breeze-icons

    anki-bin
    libreoffice-qt
    hunspell
    topgrade
    # Temporarily disabled because of
    # dependency on olm which is not maintained
    # and insecure
    # kdePackages.neochat
    ungoogled-chromium
    gimp
    krita
    fontforge

    prismlauncher
    lunar-client
  ];

  # Fix file associations for Dolphin and other KDE apps
  environment.etc."/xdg/menus/plasma-applications.menu".text = builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  services.fwupd.enable = true;
}
