{ globals, ... }: {
  programs.zsh = {
    enable = true;
  };

  home-manager.users."${globals.user}" = {
    home.file = {
      ".config/zsh/.zshrc" = {
        source = ./zshrc;
      };
      ".zshenv" = {
        source = ./zshenv;
      };
    };
  };
}
