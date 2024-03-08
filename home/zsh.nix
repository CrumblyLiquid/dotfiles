{ globals, ... }: {
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    histSize = 10000;

    shellAliases = {
      nv = "nvim";
    };

    ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" "man" "tmux" ];
    };
  };

  home-manager.users."${globals.user}" = {
    programs.zsh = {
      enable = true;

      enableCompletion = true;
      syntaxHighlighting.enable = true;
    };
  };
}
