{ globals, pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    tofi
  ];

  home-manager.users."${globals.user}" = {
    home.file = {
      ".config/tofi" = {
        source = ./../../tofi;
        recursive = true;
      };
    };
  };
}

