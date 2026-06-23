{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    typst
    tinymist # LSP
    typstyle # Formatter
    websocat # required by typst-preview
  ];
}
