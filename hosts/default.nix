{ config, lib, pkgs, inputs, ... }:

{
  imports = [ ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  # Enable touchpad support (+ tablet support)
  services.xserver.libinput.enable = true;

  time.timeZone = "Europe/Prague";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;

    # Configure keymap in X11
    xkb.layout = "us";
  };

  # Printing
  services.printing.enable = true;

  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    vim

    git
    wget
    curl
    fzf

    htop
    btop

    gcc
    clang
    rustup
    cargo
    python3

    grimblast
    dunst

    firefox
    thunderbird
    dolphin
    kate
    filelight
    vlc
    gwenview
    keepassxc
    audacity

    logisim-evolution
    # mathematica
  ];

  fonts.packages = with pkgs; [
    nerdfonts
    meslo-lgs-nf
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  users.users.crumbly = {
    isNormalUser = true;
    extraGroups =
      let nm = if config.networking.networkmanager.enable then [ "networkmanager" ] else [ ];
      in [ "wheel" ] ++ nm;
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  /*
    environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_DIRS = "/etc/xdg";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_DIRS = "/usr/local/share/:/usr/share/";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    };
  */

  # Fix running dynamically linked binaries
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ ];
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  nixpkgs.config.allowUnfree = true;
}

