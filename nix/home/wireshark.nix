{ pkgs, globals, ... }:
{
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  users.groups.wireshark = {
    members = [ "${globals.user}" ];
  };

  # Allow Wireshark to analyze USB traffic as an unprivileged user
  # https://discourse.nixos.org/t/using-wireshark-as-an-unprivileged-user-to-analyze-usb-traffic/38011/3
  services.udev = {
    extraRules = ''
      SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
    '';
  };
}
