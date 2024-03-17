{ globals, inputs, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    git
    gcc
    clang
    clang-tools
    gnumake
    gdb

    rustup
    cargo

    python3

    nil
    lua-language-server
    nixpkgs-fmt
    rnix-lsp

  ];

  # home-manager.users."${globals.user}" = {
  # };
}

