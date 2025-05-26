{ globals, pkgs, config, ... }: {
  # Updated version of tofi
  # (supports the matching-algorithm option)
  nixpkgs.overlays = [
    (final: prev:
      {
        tofi = prev.tofi.overrideAttrs (old: {
          src = prev.fetchFromGitHub {
            owner = "philj56";
            repo = "tofi";
            rev = "1eb6137572ab6c257ab6ab851d5d742167c18120";
            hash = "sha256-OD56rwDrXgb5pg85sT5v+zl9A1/sfn77PBSG4gT76bE=";
          };
        });
      }
    )
  ];

  environment.systemPackages = with pkgs; [
    tofi
  ];
}

