{ pkgs, globals, ... }: {
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };


  users.groups.wireshark = {
    members = [ "${globals.user}" ];
  };

  services.udev = {
    extraRules = ''
      SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
    '';
  };
}


