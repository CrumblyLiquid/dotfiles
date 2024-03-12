{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gns3-gui
    gns3-server
    dynamips
    ubridge
    qemu
  ];

  security.wrappers.ubridge = {
    source = "${pkgs.ubridge}/bin/ubridge";
    capabilities = "cap_net_admin,cap_net_raw=ep";
    owner = "root";
    group = "wireshark";
    permissions = "u+rx,g+x";
  };
}

