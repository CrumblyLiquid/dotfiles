{ globals, inputs, pkgs, ... }:
{
  # environment.enableDebugInfo = true;
  environment.systemPackages = with pkgs; [
    vmpk
  ];

  # home-manager.users."${globals.user}" = {
  # };
}

