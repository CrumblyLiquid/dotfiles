{ globals, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    jq
    socat
  ];

  home-manager.users."${globals.user}" = {
    programs.eww = {
      enable = true;
      configDir = ./.;
    };
  };
}

