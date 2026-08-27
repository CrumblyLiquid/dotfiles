{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_7_1;

  boot.loader.systemd-boot.enable = true;
  # Set resolution to the maximum
  boot.loader.systemd-boot.consoleMode = "max";

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
  # i18n.inputMethod = {
  #   enable = true;
  #
  #   type = "fcitx5";
  #   fcitx5 = {
  #     waylandFrontend = true;
  #     addons = with pkgs; [
  #       fcitx5-mozc
  #       fcitx5-gtk
  #     ];
  #   };
  # };

  services.xserver = {
    enable = true;
    # Configure keymap in X11
    xkb.layout = "us";
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = "greeter";
        command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --user-menu --remember --remember-user-session --cmd Hyprland";
      };
    };
  };

  # Don't shutdown on power button press but suspend instead!
  # https://wiki.nixos.org/wiki/Systemd/logind
  services.logind.settings.Login.HandlePowerKey = "suspend";

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    zip
    unzip
    gnupg
    sops
    age
    ssh-to-age
    cryptsetup
  ];

  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  users.users.crumbly = {
    isNormalUser = true;
    extraGroups = [
      # Required for default `sudo` configuration
      "wheel"
      # Control NetworkManager
      "networkmanager"
      # Manage input devices
      "input"
    ];
    packages = with pkgs; [ ];
    # TODO: Explore other shells
    shell = pkgs.zsh;
  };

  # Fix running dynamically linked binaries
  # https://wiki.nixos.org/wiki/Nix-ld
  programs.nix-ld = {
    enable = true;
    # TODO: Add sensible libraries
    # https://github.com/NixOS/nixpkgs/issues/354513
    libraries = with pkgs; [ ];
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  nixpkgs.config.allowUnfree = true;
}
