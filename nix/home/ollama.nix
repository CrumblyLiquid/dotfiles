{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.ollama-rocm
    pkgs.opencode
    pkgs.opencode-desktop
  ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    environmentVariables = {
      HCC_AMDGPU_TARGET = "gfx1031";
    };
    rocmOverrideGfx = "10.3.0";
  };
}
