{ globals, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Neovim stuff
    neovim
    tree-sitter

    # Language stuff
    # TODO: Language options flake (with preinstalled lsps, formatters, etc)
    ast-grep

    # Lua
    stylua
    lua-language-server
    luajitPackages.lua-lsp

    # Rust
    rust-analyzer

    # Haskell
    haskell-language-server

    # TODO: Bacon, Bacon-ls (https://github.com/crisidev/bacon-ls?tab=readme-ov-file#nix)
    # C/C++
    cmake
    clang
    clang-tools
    gcc
    gccNGPackages_15.libstdcxx

    # Python
    basedpyright
    ruff
    # python312Packages.python-lsp-ruff

    # SQL
    sqruff

    # Bash
    bash-language-server

    # JSON
    nodePackages.vscode-json-languageserver

    # Yaml
    yaml-language-server

    # Typst
    tinymist # LSP
    typstyle # Formatter
    websocat # required by typst-preview

    # LaTeX
    ltex-ls-plus

    # HTML
    emmet-language-server
    prettierd
    vscode-langservers-extracted

    # Nix
    nil
    nixpkgs-fmt

    # R
    air-formatter

    # PHP
    phpactor
    php
    php84Packages.phan
    php84Packages.composer
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

    /*
      home.file = {
        ".config/nvim" = {
          source = ./.;
          recursive = true;
        };
      };
    */
  };
}
