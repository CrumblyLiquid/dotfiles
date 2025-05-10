{ globals, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wezterm
  ];

  home-manager.users."${globals.user}" = {
    programs.wezterm = {
      enable = true;

      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}

