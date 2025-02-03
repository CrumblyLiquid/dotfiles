{ globals, inputs, pkgs, ... }: {
  networking.firewall = {
    enable = true;
    # Immich
    allowedTCPPorts = [ 2283 ];
  };

  # Possibly use https://wiki.nixos.org/wiki/Immich
}


