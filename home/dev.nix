{ globals, inputs, pkgs, ... }:
{
  # environment.enableDebugInfo = true;
  environment.systemPackages = with pkgs; [
    # General
    git
    gnumake

    # Editors
    # jetbrains.datagrip
    jetbrains.clion

    # Neovim stuff
    neovim
    nil
    lua-language-server
    nixpkgs-fmt

    # C/C++ things
    gcc
    clang
    clang-tools
    gdb

    # https://github.com/cyrus-and/gdb-dashboard
    # python311Packages.pygments

    tree-sitter
    lldb
    ghidra

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

    # Java stuff
    openjdk8
    openjdk17
    openjdk22

    # Rust stuff
    rustup
    cargo

    python3
    nodejs
  ];

  # home-manager.users."${globals.user}" = {
  # };
}

