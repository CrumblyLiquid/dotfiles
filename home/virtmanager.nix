{ pkgs, globals, ... }: {
  virtualisation.libvirtd.enable = true;
  # Nested virtualization
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  boot.extraModprobeConfig = "options kvm_amd nested=1";

  users.groups.libvirtd = {
    members = [ "${globals.user}" ];
  };

  programs.virt-manager.enable = true;
}

