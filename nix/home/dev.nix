{ globals, inputs, pkgs, ... }: {
  documentation = {
    enable = true;
    man = {
      enable = true;
      generateCaches = false;
    };
    dev.enable = true;
  };

  # environment.enableDebugInfo = true;
  environment.systemPackages = with pkgs; [
    # General
    git
    gnumake

    linuxPackages_latest.perf

    linux-manual
    man-pages
    man-pages-posix
    stdmanpages
    llvmPackages_18.libllvm
    llvmPackages_18.clang-manpages
    llvmPackages_18.lldb-manpages
    llvmPackages_18.llvm-manpages

    # C/C++ things
    gcc
    clang
    clang-tools
    gdb
    lldb
    valgrind
    # https://github.com/cyrus-and/gdb-dashboard

    doxygen
    graphviz

    # Rust stuff
    rustup
    cargo
    rust-analyzer

    # Java stuff
    openjdk

    # SQL
    sqlitebrowser
    sqlite
    sqlite-interactive

    # JavaScript
    nodejs

    # WooWoo
    ruby
    texliveFull
    deno
    pandoc
    pdf2svg
    poppler_utils
    dos2unix
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

    # Python
    python3
    python312Packages.mpmath
    python312Packages.pillow
    python312Packages.pandas
    python312Packages.requests
    python312Packages.pip
    python312Packages.setuptools
    python312Packages.venvShellHook
    python312Packages.virtualenv

    geckodriver
    python312Packages.selenium

    uv
    conda

    python312Packages.pygments
    python312Packages.pypdf

    # Security
    # ida-free
    # radare2
    # iaito
    # cutter
    # ghidra
    # metasploit
    burpsuite

    # Editors
    helix
    # jetbrains.datagrip
    # jetbrains.clion
    # jetbrains.rust-rover
    vscodium.fhs

    # Neovim stuff
    neovim
    nil
    lua-language-server
    nixpkgs-fmt
    ruff
    python312Packages.python-lsp-ruff

    # School design
    # iverilog
    # gtkwave
    # rars

    # libiconv
    # openssl
    # pkg-config
    #
    # libnotify
    #
    # tree-sitter
    #
    # libpng
    # libjpeg
    # libxkbcommon
    # libGL
    # wayland
    # xorg.libX11
    # xorg.libXcursor
    # xorg.libXrandr
    # xorg.libXi
  ];

  # virtualisation.docker = {
  #   enable = true;
  #   rootless = {
  #     enable = true;
  #     setSocketVariable = true;
  #   };
  #   storageDriver = "btrfs";
  # };
  #
  programs.adb.enable = true;
  users.users."${globals.user}".extraGroups = [ "docker" "kvm" ];
}

