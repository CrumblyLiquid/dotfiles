{
  globals,
  pkgs,
  ...
}:
{
  documentation = {
    enable = true;
    man = {
      enable = true;
      cache.enable = false;
    };
    dev.enable = true;
  };

  # environment.enableDebugInfo = true;
  environment.systemPackages = with pkgs; [
    smartmontools
    gsmartcontrol
    # General
    git
    gnumake
    just
    # flex
    # bison
    # ncurses
    # findutils
    # mlocate

    perf

    # https://github.com/NixOS/nixpkgs/issues/489956
    # linux-manual
    man-pages
    man-pages-posix
    stdmanpages
    llvmPackages_latest.libcxxStdenv
    # llvmPackages_18.libllvm
    # llvmPackages_18.clang-manpages
    # llvmPackages_18.lldb-manpages
    # llvmPackages_18.llvm-manpages

    # C/C++ things
    gcc
    clang
    clang-tools
    gdb
    lldb
    valgrind
    # https://github.com/cyrus-and/gdb-dashboard

    inotify-tools
    file
    trace-cmd
    kernelshark

    doxygen
    graphviz

    # Rust stuff
    rustup
    cargo
    # loco
    # sea-orm-cli

    # Haskell
    # ghc
    # haskellPackages.ghcup
    # stack

    # Lisp
    # sbcl

    # R
    # R
    # rstudio
    # rstudio-server

    # Java stuff
    openjdk

    # SQL
    # sqlitebrowser
    # sqlite
    sqlite-interactive

    # JavaScript
    nodejs

    # Typst
    typst

    # Prolog
    swi-prolog

    # WooWoo
    ruby
    texliveFull
    deno
    pandoc
    pdf2svg
    poppler-utils
    dos2unix
    gnuplot
    gnuplot_qt
    graphviz
    texlivePackages.graphviz
    texlivePackages.dejavu
    texlivePackages.libertine
    texlivePackages.luaotfload
    python314Packages.pip
    python314Packages.pygments
    python314Packages.networkx
    python314Packages.pygraphviz
    python314Packages.numpy
    python314Packages.scipy

    # Python
    python3
    python314Packages.mpmath
    python314Packages.pillow
    python314Packages.pandas
    python314Packages.requests
    python314Packages.pip
    python314Packages.setuptools
    python314Packages.venvShellHook
    python314Packages.virtualenv

    geckodriver
    python314Packages.selenium

    uv
    conda

    python314Packages.pygments
    python314Packages.pypdf

    # Security
    # ida-free
    # radare2
    # iaito
    # cutter
    # ghidra
    # metasploit
    # burpsuite

    # Editors
    # helix
    # jetbrains.datagrip
    # jetbrains.clion
    # jetbrains.rust-rover
    # vscodium.fhs

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
    #
    # libpng
    # libjpeg
    # libxkbcommon
    # libGL
    # wayland
    # xorg.libX11
    # libxcursor
    # xorg.libXrandr
    # xorg.libXi
  ];

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    # storageDriver = "btrfs";
  };

  users.users."${globals.user}".extraGroups = [
    "docker"
    "kvm"
  ];
}
