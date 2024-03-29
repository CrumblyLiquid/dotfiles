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


  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    vim

    git
    wget
    curl

    zip
    unzip

    bat
    fzf
    procps

    htop
    btop

    firefox
    thunderbird
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.ark
    kdePackages.karchive
    kdePackages.kate
    kdePackages.filelight
    kdePackages.gwenview
    kdePackages.bluez-qt
    kdePackages.breeze
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
    vlc
    gimp
    keepassxc
    audacity
    obs-studio

    logisim-evolution
    # mathematica
  ];

  fonts.packages = with pkgs; [
    nerdfonts
    meslo-lgs-nf
    noto-fonts
    noto-fonts-emoji
    font-awesome
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  users.users.crumbly = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
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

