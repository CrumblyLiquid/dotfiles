{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/OBS_Studio
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi
      obs-vkcapture
      input-overlay
    ];

    # Enable virtual camera
    # https://nixos.wiki/wiki/OBS_Studio#Using_the_Virtual_Camera
    enableVirtualCamera = true;
  };
}
