{ globals, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Neovim stuff
    neovim

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
    clang-tools

    # Python
    basedpyright
    ruff
    python312Packages.python-lsp-ruff

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

    # LaTeX
    ltex-ls-plus

    # Nix
    nil
    nixpkgs-fmt
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
