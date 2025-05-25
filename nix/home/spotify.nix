{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    spotify
    # spotifywm
    spotify-player
  ];

  # Local discovery
  # Sync local tracks from your filesystem with mobile devices in the same network
  networking.firewall.allowedTCPPorts = [ 57621 ];
  # Enable discovery of Google Cast devices
  networking.firewall.allowedUDPPorts = [ 5353 ];
}

