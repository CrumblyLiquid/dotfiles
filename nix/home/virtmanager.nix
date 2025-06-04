{ pkgs, globals, ... }: {
  # Nested virtualization
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  boot.extraModprobeConfig = "options kvm_amd nested=1";

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull ];
        };
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
  users.groups.libvirtd = {
    members = [ "${globals.user}" ];
  };
  # environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
  home-manager.users."${globals.user}" = {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
  };
  programs.virt-manager.enable = true;

  # https://github.com/NixOS/nixpkgs/issues/363887#issuecomment-2536693220
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers = {
    members = [ "${globals.user}" ];
  };
}

