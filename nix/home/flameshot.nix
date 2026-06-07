{
  globals,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    flameshot
    grim
  ];

  home-manager.users."${globals.user}" = {
    services.flameshot = {
      enable = true;
      settings = {
        General = {
          # Configure Flameshot to use Grim
          # because of Wayland
          useGrimAdapter = true;
          # Stops warnings for using Grim
          disabledGrimWarning = true;

          savePath = "/home/${globals.user}/Pictures/Screenshots";
          saveAsFileExtension = ".png";

          showStartupLaunchMessage = false;
          showAbortNotification = false;
          showHelp = true;
          showSidePanelButton = true;
        };
      };
    };
  };
}
