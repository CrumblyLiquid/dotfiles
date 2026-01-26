{
  globals,
  inputs,
  pkgs,
  ...
}:
{
  networking.firewall = {
    enable = true;
  };
}
