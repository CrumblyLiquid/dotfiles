{ config, lib, pkgs, inputs, ... }: {
  imports = [ ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  # Enable touchpad support (+ tablet support)
  services.libinput.enable = true;

  time.timeZone = "Europe/Prague";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
    "cs_CZ.UTF-8/UTF-8"
  ];
  i18n.extraLocaleSettings = {
    LC_TIME = "cs_CZ.UTF-8";
    LC_MONETARY = "cs_CZ.UTF-8";
  };

  services.xserver = {
    enable = true;
    # Configure keymap in X11
    xkb.layout = "us";
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
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
    extraGroups = [ "wheel" "networkmanager" "input" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  # Fix running dynamically linked binaries
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ ];
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  nixpkgs.config.allowUnfree = true;
}

