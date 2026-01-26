{
  globals,
  inputs,
  pkgs,
  ...
}:
{
  # Printing
  services.printing = {
    enable = true;
    drivers = with pkgs; [ hplip ];
  };

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Tiskarna";
        location = "Home";
        deviceUri = "ipp://10.0.0.101/ipp";
        model = "HP/hp-laserjet_m1530_mfp_series-ps.ppd.gz";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "Tiskarna";
  };

  environment.systemPackages = with pkgs; [
    hplip
    sane-frontends
    sane-backends
  ];
}
