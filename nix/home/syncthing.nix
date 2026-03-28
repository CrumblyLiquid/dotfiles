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
        nas = {
          name = "NAS";
          id = "OQKQMLN-YVROQRO-RHQFRVI-7BDSYEW-M7WOH3U-NC2QRQ5-HPLIBR6-V5JBDA5";
        };
        laptop = {
          name = "Laptop";
          id = "FDM5BL2-TLAVPQI-23FVPUJ-TNFJYPX-JBGI3SU-U2XGMNO-QFPVP6O-HKRTEA4";
        };
        mobile = {
          name = "Mobile";
          id = "3A35K6U-NKQJIDT-F2X42OZ-5WJP4KS-V53TXBG-VCAEP6C-CQF4X4J-SHFYFAO";
        };
        backup = {
          name = "Backup Mobile";
          id = "YYP2KOM-OT26MVS-X5USZA6-H3SKRJ2-WP2C2Q5-F75MJKK-CFUHBB6-WJBFFQ2";
        };
      };
      folders = {
        "Misc" = {
          path = "/home/${globals.user}/Misc";
          devices = [
            "nas"
            "laptop"
            "mobile"
            "backup"
          ];
        };
        "Books" = {
          path = "/home/${globals.user}/Books";
          devices = [
            "nas"
            "laptop"
            "mobile"
            "backup"
          ];
        };
        "School" = {
          path = "/home/${globals.user}/School";
          devices = [
            "nas"
            "laptop"
          ];
        };
      };
    };
  };
}
