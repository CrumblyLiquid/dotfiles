{ globals, inputs, pkgs, ... }: {
  imports = [
    # https://github.com/musnix/musnix
    inputs.musnix.nixosModules.musnix
  ];

  # Following https://discourse.nixos.org/t/lmms-vst-plugins/42985/3
  environment.systemPackages = with pkgs; [
    audacity
    lmms
    ardour

    # VSTs
    vital
    infamousPlugins
    lsp-plugins

    # Windows VSTs
    yabridge
    yabridgectl
  ];

  users.users."${globals.user}".extraGroups = [ "audio" ];

  musnix = {
    enable = true;
    rtcqs.enable = true;
  };
}
