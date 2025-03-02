{ globals, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    pkgs.librewolf
    pkgs.firefox
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    languagePacks = [ "cs" "de" "en-GB" "en-US" ];
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };

  home-manager.users."${globals.user}" = {
    home.sessionVariables = {
      DEFAULT_BROWSER = "${pkgs.librewolf}/bin/librewolf";
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "librewolf.desktop";
        "x-scheme-handler/http" = "librewolf.desktop";
        "x-scheme-handler/https" = "librewolf.desktop";
        "x-scheme-handler/about" = "librewolf.desktop";
        "x-scheme-handler/unknown" = "librewolf.desktop";
      };
    };
  };
}
