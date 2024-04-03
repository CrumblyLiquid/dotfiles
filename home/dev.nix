{ globals, inputs, pkgs, ... }:
{
  # environment.enableDebugInfo = true;
  environment.systemPackages = with pkgs; [
    neovim
    git
    gcc
    clang
    clang-tools
    gnumake
    gdb

    avrdude
    avrdudess
    avra
    avro-c
    avr-sim
    avro-cpp
    avro-tools
    # gavrasm
    # simavr
    openjdk8
    openjdk17
    openjdk19

    rustup
    cargo

    python3

    nil
    lua-language-server
    nixpkgs-fmt
    rnix-lsp

    jetbrains.datagrip
    jetbrains.clion
  ];

  # home-manager.users."${globals.user}" = {
  # };
}

