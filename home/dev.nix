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
    tree-sitter
    lldb
    fzf
    dig
    outils
    bvi
    pwntools
    rsbkb
    p7zip

    virtualbox

    nodejs
    libpng
    libjpeg
    doxygen
    graphviz
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
    openjdk22
    ghidra

    rustup
    cargo

    python3

    nil
    lua-language-server
    nixpkgs-fmt

    jetbrains.datagrip
    jetbrains.clion
  ];

  # home-manager.users."${globals.user}" = {
  # };
}

