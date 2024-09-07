{ globals, pkgs, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    languagePacks = [ "cs" "de" "en-GB" "en-US" ];
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };

  home-manager.users."${globals.user}" = {
    home.sessionVariables = {
      DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
    };
  };
}
