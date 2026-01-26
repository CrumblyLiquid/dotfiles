{ pkgs, globals, ... }:
{
  services.syncthing = {
    enable = true;
    user = "${globals.user}";
    dataDir = "/home/${globals.user}/Sync";
    configDir = "/home/${globals.user}/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      options = {
        /*
          localAnnounceEnabled = false;
          globalAnnounceEnabled = false;
          relaysEnabled = false;
        */
        urAccepted = -1;
      };
      # https://docs.syncthing.net/users/faq.html#should-i-keep-my-device-ids-secret
      devices = {
        "laptop" = {
          id = "FDM5BL2-TLAVPQI-23FVPUJ-TNFJYPX-JBGI3SU-U2XGMNO-QFPVP6O-HKRTEA4";
        };
        "mobile" = {
          id = "3A35K6U-NKQJIDT-F2X42OZ-5WJP4KS-V53TXBG-VCAEP6C-CQF4X4J-SHFYFAO";
        };
      };
      folders = {
        "Misc" = {
          path = "/home/${globals.user}/Misc";
          devices = [
            "laptop"
            "mobile"
          ];
        };
        "Books" = {
          path = "/home/${globals.user}/Books";
          devices = [
            "laptop"
            "mobile"
          ];
        };
        "School" = {
          path = "/home/${globals.user}/School";
          devices = [ "laptop" ];
        };
        "Photos" = {
          path = "/home/${globals.user}/Pictures/Pixel";
          devices = [ "mobile" ];
        };
      };
    };
  };
}
