{ globals, pkgs, ... }: {

  # Tablet
  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };

  home-manager.users."${globals.user}" = {
    home.file = {
      ".config/OpenTabletDriver/settings.json" = {
        text = builtins.readFile ./settings.json;
      };
    };
  };
}

