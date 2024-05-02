{ globals, inputs, pkgs, ... }:
{
  # environment.enableDebugInfo = true;
  environment.systemPackages = with pkgs; [
    anki-bin
    aseprite

    neovim
    git
    gcc
    clang
    clang-tools
    gnumake
    gdb
    busybox
    ripgrep
    eza
    bat

    nmap

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
    ghidra

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

