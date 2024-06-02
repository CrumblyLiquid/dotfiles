{ globals, ... }: {
  programs.zsh = {
    enable = true;
  };

  home-manager.users."${globals.user}" = {
    home.file = {
      "~/.zshrc" = {
        source = ./../zsh/zshrc;
      };
      "~/.zshenv" = {
        source = ./../zsh/zshenv;
      };
    };
  };
}
