{ globals, pkgs, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "librewolf-bin-151.0.1-2"
    "librewolf-bin-unwrapped-151.0.1-2"
  ];

  environment.systemPackages = [
    pkgs.librewolf-bin
    # pkgs.tor
    pkgs.firefox
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.librewolf-bin;
    languagePacks = [
      "cs"
      "de"
      "en-GB"
      "en-US"
    ];
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };

  home-manager.users."${globals.user}" = {
    home.sessionVariables = {
      DEFAULT_BROWSER = "${pkgs.librewolf-bin}/bin/librewolf";
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
