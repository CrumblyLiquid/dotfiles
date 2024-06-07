{ globals, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    anki-bin
    libreoffice-qt
    hunspell
    kdePackages.neochat
    ungoogled-chromium
    vlc
    mpv
  ];
}
