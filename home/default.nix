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
    ./firefox.nix
    ./spotify.nix
    ./steam.nix
    ./opentabletdriver.nix
    ./xournalpp.nix
    ./gns3.nix
    ./wireshark.nix
    ./virtmanager.nix
    ./syncthing.nix
    ./dev.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  home-manager.users."${globals.user}" = {
    xdg.configFile."wallpaper" = { source = globals.wallpaper; };

    home.packages = with pkgs; [ ];
    home.file = { };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };

}
