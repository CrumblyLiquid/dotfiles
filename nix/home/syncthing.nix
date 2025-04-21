{ pkgs, globals, ... }: {
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
        "laptop" = { id = "GU3XLR2-MLFV3M2-2CJYBDE-WHSIHHH-H3RRNXB-TZEDVON-2W5VDO6-Y2YE3QN"; };
        "mobile" = { id = "KFCIMYO-Q6LLB4R-N4GSJTK-K73JDXF-NMNXO65-P7DQVVE-DNVWWQF-DBLLKQZ"; };
      };
      folders = {
        "Misc" = {
          path = "/home/${globals.user}/Misc";
          devices = [ "laptop" "mobile" ];
        };
        "School" = {
          path = "/home/${globals.user}/School";
          devices = [ "laptop" "mobile" ];
        };
        "Photos" = {
          path = "/home/${globals.user}/Pictures/Pixel";
          devices = [ "mobile" ];
        };
      };
    };
  };
}

