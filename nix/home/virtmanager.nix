{ pkgs, globals, ... }: {
  # Nested virtualization
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  boot.extraModprobeConfig = "options kvm_amd nested=1";

  virtualisation.libvirtd.enable = true;
  users.groups.libvirtd = {
    members = [ "${globals.user}" ];
  };
  programs.virt-manager.enable = true;

  virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  # virtualisation.virtualbox.guest.enable = true;
  # virtualisation.virtualbox.guest.dragAndDrop = true;
  virtualisation.virtualbox.guest.clipboard = true;
  users.extraGroups.vboxusers = {
    members = [ "${globals.user}" ];
  };
}

