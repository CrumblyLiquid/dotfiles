{ globals, inputs, pkgs, ... }:
{
  # https://nixos.wiki/wiki/Qmk
  hardware.keyboard.qmk.enable = true;

  environment.systemPackages = with pkgs; [
    qmk
    via
  ];

  service.udev.packages = [ pkgs.via ];
}


