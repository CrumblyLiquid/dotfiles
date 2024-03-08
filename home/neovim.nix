{ globals, pkgs, ... }:
{
  home-manager.users."${globals.user}" = {
    programs.neovim = {
      enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      defaultEditor = true;

      extraLuaConfig = ''
        ${builtins.readFile ./../nvim/init.lua}
      '';
    };

    programs.zsh.shellAliases = {
      nv = "nvim";
    };
  };
}

