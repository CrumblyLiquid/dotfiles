{ globals, ... }: {
  programs.zsh = {
    enable = true;
  };

  home-manager.users."${globals.user}" = {
    home.file = {
      ".config/zsh/.zshrc" = {
        source = ./../../zsh/zshrc;
      };
      ".zshenv" = {
        source = ./../../zsh/zshenv;
      };
    };
  };
}
