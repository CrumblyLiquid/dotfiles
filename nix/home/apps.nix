{ globals, pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    thunderbird

    vlc
    mpv

    keepassxc
    audacity
    lmms

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

  services.fwupd.enable = true;
}
