{ pkgs, globals, ... }: {
  environment.systemPackages = with pkgs; [
    zoxide # Better cd
    zellij # Terminal multiplexer
    fzf
    fd
    busybox
    ripgrep
    htop # Better top
    btop # Even better top

    eza # Better ls
    bat # Better cat
    dig
    dogdns # Better dig
    outils
    bvi # Binary Visual Editor
    pwntools
    rsbkb
    p7zip
    zip
    unzip
    curl
    wget
    git
    nmap

    tldr # Community maintained man pages
    jid # Interactive tool to build jq queries
    pv # Monitor progress through a pipe
    scc # Lines of code counter
    duf # Disk usage
    diff-so-fancy # Better diff
    exiftool # Reading + writing metadata
    speedtest-cli # Speedtest from terminal
    httpie # Terminal HTTP client

    lolcat
    figlet
    cowsay
    sl
  ];
}
