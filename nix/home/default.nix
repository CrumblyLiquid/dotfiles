{
  inputs,
  globals,
  ...
}:
{
  imports =
    let
      base = ./../..;
    in
    [
      inputs.home-manager.nixosModules.default
      ./fixes.nix
      ./theming.nix
      ./firewall.nix

      ./sound.nix
      ./music.nix
      ./keyboard.nix
      ./bluetooth.nix
      ./printing.nix
      ./dev.nix
      ./vpn.nix
      ./android.nix
      (base + /ssh)

      ./typst.nix

      # Applications
      ./flatpak.nix
      ./apps.nix
      ./gaming.nix
      ./fun.nix
      ./firefox.nix
      ./obs.nix
      ./spotify.nix
      (base + /opentabletdriver)
      (base + /xournalpp)
      # ./ollama.nix
      # ./gns3.nix
      ./wireshark.nix
      ./virtmanager.nix
      ./syncthing.nix

      # Terminal
      ./terminal.nix
      (base + /kitty)
      (base + /ghostty)
      # (base + /wezterm)
      (base + /zsh)
      (base + /nushell)
      (base + /starship)
      (base + /nvim)
      (base + /helix)
      (base + /tmux)

      # Window Manager
      (base + /hypr)
      (base + /tofi)
      (base + /eww)
      (base + /dunst)
      # (base + /swayidle)
      # (base + /swaylock)
      (base + /wpaperd)
      (base + /waybar)
      (base + /ashell)
      # (base + /quickshell)

      # (base + /kde)
      # (base + /cosmic)
    ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  home-manager.users."${globals.user}" = {
    xdg.enable = true;
    # xdg.configFile."wallpaper.png" = { source = globals.wallpaper; };
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        # Images -> Gwenview
        "image/png" = "org.kde.gwenview.desktop";
        "image/jpeg" = "org.kde.gwenview.desktop";
        "image/gif" = "org.kde.gwenview.desktop";
        "image/webp" = "org.kde.gwenview.desktop";
        "image/avif" = "org.kde.gwenview.desktop";
        "image/tiff" = "org.kde.gwenview.desktop";
        "image/bmp" = "org.kde.gwenview.desktop";
        "image/x-icon" = "org.kde.gwenview.desktop";
        "image/svg+xml" = "org.kde.gwenview.desktop";
        "image/heif" = "org.kde.gwenview.desktop";
        "image/jxl" = "org.kde.gwenview.desktop";

        # Audio / Video -> VLC
        "audio/mpeg" = "vlc.desktop"; # .mp3
        "audio/mp4" = "vlc.desktop"; # .m4a/.aac
        "audio/flac" = "vlc.desktop";
        "audio/ogg" = "vlc.desktop";
        "audio/x-wav" = "vlc.desktop";
        "audio/aac" = "vlc.desktop";
        "audio/opus" = "vlc.desktop";
        "video/mp4" = "vlc.desktop";
        "video/x-matroska" = "vlc.desktop"; # .mkv
        "video/webm" = "vlc.desktop";
        "video/quicktime" = "vlc.desktop"; # .mov
        "video/x-msvideo" = "vlc.desktop"; # .avi
        "video/mpeg" = "vlc.desktop";

        # Documents -> Okular
        "application/pdf" = "org.kde.okular.desktop";
        "application/epub+zip" = "org.kde.okular.desktop";
        "application/x-mobipocket-ebook" = "org.kde.okular.desktop";
        "image/vnd.djvu" = "org.kde.okular.desktop";
        "application/vnd.comicbook+zip" = "org.kde.okular.desktop"; # .cbz
        "application/postscript" = "org.kde.okular.desktop";

        # Archives -> Ark
        "application/zip" = "org.kde.ark.desktop";
        "application/x-tar" = "org.kde.ark.desktop";
        "application/gzip" = "org.kde.ark.desktop";
        "application/x-bzip2" = "org.kde.ark.desktop";
        "application/x-xz" = "org.kde.ark.desktop";
        "application/zstd" = "org.kde.ark.desktop";
        "application/x-7z-compressed" = "org.kde.ark.desktop";
        "application/vnd.rar" = "org.kde.ark.desktop";
        "application/x-compressed-tar" = "org.kde.ark.desktop"; # .tar.gz

        # Disk images -> Ark
        "application/x-iso9660-image" = "org.kde.ark.desktop";
        "application/x-cd-image" = "org.kde.ark.desktop";

        # Text / code -> Kate
        "text/plain" = "org.kde.kate.desktop";
        "text/csv" = "org.kde.kate.desktop";
        "text/markdown" = "org.kde.kate.desktop";
        "text/x-python" = "org.kde.kate.desktop";
        "text/x-shellscript" = "org.kde.kate.desktop";
        "application/json" = "org.kde.kate.desktop";
        "application/xml" = "org.kde.kate.desktop";
        "text/xml" = "org.kde.kate.desktop";
        "application/x-yaml" = "org.kde.kate.desktop";
        "application/toml" = "org.kde.kate.desktop";

        # Web -> browser + Dolphin for folders
        "text/html" = "librewolf.desktop";
        "x-scheme-handler/http" = "librewolf.desktop";
        "x-scheme-handler/https" = "librewolf.desktop";
        "inode/directory" = "org.kde.dolphin.desktop";

        # Word processing -> LibreOffice Writer
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop"; # .docx
        "application/msword" = "writer.desktop"; # .doc
        "application/vnd.oasis.opendocument.text" = "writer.desktop"; # .odt
        "application/rtf" = "writer.desktop";

        # Spreadsheets -> LibreOffice Calc
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "calc.desktop"; # .xlsx
        "application/vnd.ms-excel" = "calc.desktop"; # .xls
        "application/vnd.oasis.opendocument.spreadsheet" = "calc.desktop"; # .ods

        # Presentations -> LibreOffice Impress
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "impress.desktop"; # .pptx
        "application/vnd.ms-powerpoint" = "impress.desktop"; # .ppt
        "application/vnd.oasis.opendocument.presentation" = "impress.desktop";

        # Torrent -> qBittorrent
        "application/x-bittorrent" = "org.qbittorrent.qBittorrent.desktop";
        "x-scheme-handler/magnet" = "org.qbittorrent.qBittorrent.desktop";

        # Mail/calendar -> Thunderbird
        "x-scheme-handler/mailto" = "thunderbird.desktop";
        "text/calendar" = "thunderbird.desktop"; # .ics

        # Image files
        "image/x-xcf" = "gimp.desktop"; # GIMP native
        "image/vnd.adobe.photoshop" = "org.kde.krita.desktop"; # .psd (or gimp.desktop)
        "image/openraster" = "org.kde.krita.desktop"; # .ora

        # Fonts -> KFontView
        "font/ttf" = "org.kde.kfontview.desktop";
        "font/otf" = "org.kde.kfontview.desktop";
        "application/x-font-ttf" = "org.kde.kfontview.desktop";
      };
    };

    # home.packages = with pkgs; [ ];
    # home.file = { };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };

}
