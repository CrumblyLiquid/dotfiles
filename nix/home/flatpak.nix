{
  lib,
  globals,
  inputs,
  pkgs,
  ...
}:
{
  services.flatpak = {
    enable = true;
  };

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      # Automatically add Flathub repo
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      # Fix fonts and themes access
      flatpak --user override --filesystem=$HOME/.local/share/fonts:ro
      flatpak --user override --filesystem=$HOME/.icons:ro
      flatpak --user override --filesystem=/nix/store:ro
    '';
  };

  # https://nixos.wiki/wiki/Fonts#Flatpak_applications_can.27t_find_system_fonts
  fonts.fontDir.enable = true;
}
