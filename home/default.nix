{ inputs, globals, pkgs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
    # ./plasma.nix
    ./terminal.nix
    ./kitty.nix
    ./zsh.nix
    ./starship.nix
    ./neovim.nix
    ./tmux.nix
    ./hyprland.nix
    ./tofi.nix
    ./eww.nix
    ./spotify.nix
    ./steam.nix
    ./opentabletdriver.nix
    ./xournalpp.nix
    ./gns3.nix
    ./wireshark.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  home-manager.users."${globals.user}" = {
    home.sessionVariables = {
      # Fix Electron apps on Nixos Wayland
      NIXOS_OZONE_WL = "1";

      DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
    };

    home.packages = with pkgs; [ ];

    home.file = { };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };

}
