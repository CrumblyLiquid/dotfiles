{ globals, pkgs, ... }:
{
  home-manager.users."${globals.user}" = {
    programs.neovim = {
      enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      defaultEditor = true;
    };

    programs.zsh.shellAliases = {
      nv = "nvim";
    };

    home.file = {
      ".config/nvim" = {
        source = ./.;
        recursive = true;
      };
    };
  };
}

