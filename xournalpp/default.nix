{ globals, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    xournalpp
  ];

  home-manager.users."${globals.user}" = {
    home.file = {
      ".config/xournalpp" = {
        source = ./../../xournalpp;
        recursive = true;
      };
    };
  };
}

