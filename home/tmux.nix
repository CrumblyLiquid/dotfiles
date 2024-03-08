{ globals, pkgs, ... }: {
  home-manager.users."${globals.user}" = {
    programs.tmux = {
      enable = true;
      extraConfig = ''
        ${builtins.readFile ./../tmux/tmux.conf}
      '';
    };
  };
}

