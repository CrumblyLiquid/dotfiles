{ globals, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Neovim stuff
    neovim

    # Language stuff
    # TODO: Language options flake (with preinstalled lsps, formatters, etc)
    ast-grep

    # Lua
    luajitPackages.lua-lsp
    # Rust
    rust-analyzer
    # TODO: Bacon, Bacon-ls (https://github.com/crisidev/bacon-ls?tab=readme-ov-file#nix)
    # C/C++
    clang-tools
    # Python
    pyright # TODO: basedpyright
    # Bash
    bash-language-server
    # JSON
    nodePackages.vscode-json-languageserver
    # Yaml
    yaml-language-server
    # Typst
    tinymist # LSP
    typstyle # Formatter
    # Nix
    nil
  ];


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

    /* home.file = {
      ".config/nvim" = {
        source = ./.;
        recursive = true;
      };
    }; */
  };
}

