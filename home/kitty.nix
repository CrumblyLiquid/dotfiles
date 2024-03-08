{ globals, pkgs, ... }: {
  home-manager.users."${globals.user}" = {
    programs.kitty = {
      enable = true;
      package = pkgs.kitty;

      font = {
        package = pkgs.meslo-lgs-nf;
        name = "MesloLGS NF";
        size = 16;
      };

      settings = {
        scrollback_lines = 10000;
        enable_audio_bell = false;
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        background_opacity = 1;
        window_padding_width = 2;
        map = "ctrl+shift+n no_op";
      };

      shellIntegration = {
        enableBashIntegration = true;
        enableZshIntegration = true;
        enableFishIntegration = true;
      };

      theme = "Catppuccin-Mocha";
    };
  };
}

