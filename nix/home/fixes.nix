{ globals, inputs, pkgs, ... }: {
  nixpkgs.overlays = [
    # https://github.com/NixOS/nixpkgs/issues/380196
    (final: prev: {
        lldb = prev.lldb.overrideAttrs (old: {
          dontCheckForBrokenSymlinks = true;
        });
      }
    )
  ];
}

