{ pkgs, config, ... }: {
  # https://nixos.wiki/wiki/OBS_Studio
  environment.systemPackages = [
    # Search for modules: https://search.nixos.org/packages?channel=unstable&from=0&size=50&buckets=%7B%22package_attr_set%22%3A%5B%22obs-studio-plugins%22%5D%2C%22package_license_set%22%3A%5B%5D%2C%22package_maintainers_set%22%3A%5B%5D%2C%22package_platforms%22%3A%5B%5D%7D&sort=relevance&type=packages&query=obs-
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi
        obs-vkcapture
        input-overlay
      ];
    })
  ];

  # Enable virtual camera
  # https://nixos.wiki/wiki/OBS_Studio#Using_the_Virtual_Camera
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;
}
