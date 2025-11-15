{
  globals,
  inputs,
  pkgs,
  ...
}:
{
  # environment.enableDebugInfo = true;
  environment.systemPackages = with pkgs; [
    # aseprite # Pixel art
    # vmpk # Virtual piano
  ];

  # home-manager.users."${globals.user}" = {
  # };
}
