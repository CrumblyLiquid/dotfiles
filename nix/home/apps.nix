{ globals, pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    firefox
    thunderbird

    vlc
    mpv

    keepassxc
    audacity
    obs-studio

    kdePackages.dolphin
    kdePackages.dolphin-plugins
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
    kdePackages.neochat
    ungoogled-chromium
    gimp
    fontforge
  ];
}
