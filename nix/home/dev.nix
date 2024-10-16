{ globals, inputs, pkgs, ... }:
{
  # environment.enableDebugInfo = true;
  environment.systemPackages = with pkgs; [
    # General
    git
    gnumake
    loc

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
    ruff-lsp
    ruff

    uv
    conda

    # https://github.com/cyrus-and/gdb-dashboard
    # python311Packages.pygments

    nodejs

    ruby
    texlive.combined.scheme-small
    deno

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

