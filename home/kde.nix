{ globals, inputs, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libsForQt5.polonium
  ];

  # home-manager.users."${globals.user}" = {
  # };
}

