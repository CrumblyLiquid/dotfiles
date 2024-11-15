{ globals, pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };
  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    # bluez
  ];
}

