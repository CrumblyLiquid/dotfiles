{
  globals,
  inputs,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    typst
    # typstyle
    # typstfmt
    # typst-live
    # typstwriter
    # python312Packages.typst
  ];
}
