{
  globals,
  inputs,
  pkgs,
  ...
}:
{
  # environment.enableDebugInfo = true;
  environment.systemPackages = with pkgs; [
    android-tools
    android-studio
    android-studio-tools
    flutter
  ];

  nixpkgs.config.android_sdk.accept_license = true;

  virtualisation.waydroid.enable = true;

  # services.udev.packages = with pkgs; [
  #   android-udev-rules
  # ];

  programs.adb.enable = true;
  users.users."${globals.user}".extraGroups = [
    "adbusers"
    "kvm"
  ];
}
