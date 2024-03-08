{ pkgs, globals, ... }: {
  environment.systemPackages = with pkgs; [
    zoxide
    fzf
    fd
  ];

  home-manager.users."${globals.user}" = {
    programs.zoxide.enable = true;
  };
}
