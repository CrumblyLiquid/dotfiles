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
        confirm_os_window_close = 0;
        scrollback_lines = 10000;
        enable_audio_bell = false;
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        background_opacity = 0.95;
        window_padding_width = 2;
        map = "ctrl+shift+n no_op";
        cursor_trail = 1;
        cursor_trail_decay = "0.08 0.15";
      };

      shellIntegration = {
        enableBashIntegration = true;
        enableZshIntegration = true;
        enableFishIntegration = true;
      };

      themeFile = "Catppuccin-Mocha";
    };
  };
}

