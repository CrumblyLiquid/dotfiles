{ pkgs, ... }:
{

  # Use latest Git version since it fixes
  # https://github.com/danyspin97/wpaperd/issues/126
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     wpaperd = prev.wpaperd.overrideAttrs (old: rec {
  #       src = prev.fetchFromGitHub {
  #         owner = "danyspin97";
  #         repo = "wpaperd";
  #         rev = "5d77a86bcea815f01499cfde1f75af20d8429c1c";
  #         hash = "sha256-pa90L4vuGG+nRRxJwbrbHjAwFSFJuUF9ws+JHMxi3f8=";
  #       };
  #       # cargoHash = "";
  #       cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
  #         inherit src;
  #         hash = "sha256-Vz5x9V+q5OwRR/GdiM/kEEfENSQ+KyN3DKM35NHuzAk=";
  #       };
  #     });
  #   }
  #
  #   )
  # ];

  environment.systemPackages = with pkgs; [
    wpaperd
  ];
}
