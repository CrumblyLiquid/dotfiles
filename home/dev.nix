{ globals, inputs, pkgs, ... }:
{
  # environment.enableDebugInfo = true;
  environment.systemPackages = with pkgs; [
    anki-bin
    aseprite
    libreoffice-qt
    hunspell

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

    nodejs
    libpng
    libxkbcommon
    libGL
    wayland
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi

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

