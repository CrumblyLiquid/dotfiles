{
  lib,
  globals,
  inputs,
  pkgs,
  ...
}:
{
  # Compile in Wayland support through `grim`
  nixpkgs.overlays = [
    (final: prev: {
      flameshot = prev.flameshot.overrideAttrs (oldAttrs: {
        cmakeFlags = oldAttrs.cmakeFlags ++ [ (lib.cmakeBool "USE_WAYLAND_GRIM" true) ];
      });
    })
  ];

  environment.systemPackages = with pkgs; [
    # flameshot
    grim
  ];

  home-manager.users."${globals.user}" = {
    home.file = {
      /*
        ".config/flameshot/flameshot.ini" = {
          source = ./../../flameshot/flameshot.ini;
        };
      */
    };
  };
}
