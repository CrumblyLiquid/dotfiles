{ globals, inputs, pkgs, ... }:
{
  # environment.enableDebugInfo = true;
  environment.systemPackages = with pkgs; [
    # General
    git
    gnumake
    loc

    openssl

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
    valgrind

    iverilog
    gtkwave

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
    rust-analyzer
    libiconv
    openssl
    pkg-config
    sqlitebrowser
    sqlite
    sqlite-interactive

    python3

    python312Packages.selenium
    python312Packages.mpmath
    python312Packages.pillow
    python312Packages.pandas
    python312Packages.requests
    python312Packages.pip
    python312Packages.setuptools
    python312Packages.venvShellHook
    python312Packages.virtualenv
    python312Packages.python-lsp-ruff
    python312Packages.conda
    ruff-lsp
    ruff

    uv
    conda

    jupyter-all
    python312Packages.jupyter-core

    # https://github.com/cyrus-and/gdb-dashboard
    # python311Packages.pygments

    nodejs

    ruby
    texliveFull
    deno
    pandoc
    pdf2svg
    poppler_utils
    dos2unix
    toybox
    gnuplot
    gnuplot_qt
    graphviz
    texlivePackages.graphviz
    texlivePackages.dejavu
    texlivePackages.libertine
    texlivePackages.luaotfload
    python312Packages.pip
    python312Packages.pygments
    python312Packages.networkx
    python312Packages.pygraphviz
    python312Packages.numpy
    python312Packages.scipy

    rars

    geckodriver
    libnotify
  ];

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    storageDriver = "btrfs";
  };
  users.users."${globals.user}".extraGroups = [ "docker" ];
}

