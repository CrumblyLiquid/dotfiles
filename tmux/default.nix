{ globals, pkgs, ... }: {
  # home-manager.users."${globals.user}" = {
  #   programs.tmux = {
  #     enable = true;
  #     extraConfig = ''
  #       ${builtins.readFile ./tmux.conf}
  #     '';
  #   };
  # };

  environment.systemPackages = with pkgs; [
    tmux
  ];
}

