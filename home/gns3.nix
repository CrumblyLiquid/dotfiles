{ pkgs, globals, ... }: {
  environment.systemPackages = with pkgs; [
    gns3-gui
    gns3-server
    dynamips
    ubridge
    qemu
    libvirt
    kvmtool
  ];

  users.groups.ubridge = {
    members = [ "${globals.user}" ];
  };

  security.wrappers."ubridge" = {
    source = "${pkgs.ubridge.out}/bin/ubridge";
    capabilities = "cap_net_admin,cap_net_raw=ep";
    owner = "root";
    group = "ubridge";
    permissions = "u+rx,g+x";
  };
}

