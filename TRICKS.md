# Tricks

## Make CS2 use Wayland

Source: https://www.reddit.com/r/linux_gaming/comments/1ap67bh/counterstrike_2_how_to_native_wayland_support/

1. Go to `~/.steam/steam/steamapps/common/Counter-Strike Global Offensive/game`
2. Edit `cs2.sh` and change `export SDL_VIDEO_DRIVER=x11` to `export SDL_VIDEO_DRIVER=wayland`

# Fixes

## Cargo or Rustup

### error: could not create home directory: '/rustup': Permission denied (os error 13)

Caused by CARGO_HOME and RUSTUP_HOME environment variables being set wrong
(to `/cargo` and `/rustup`)

That was caused by the XDG environment variables not being set
but `CARGO_HOME` and `RUSTUP_HOME` were set to
`"$XDG_DATA_HOME"/cargo` or `rustup`

# Observations

## NixOS

It seems to me that the technology is very promising
but the weird language (Nix) and the lack of good straight forward documentations
is a high barrier to overcome

## NixOS Flakes based configuration

Every flake has multiple inputs (dependencies) and outputs.

If you want to configure a system with it, the output should be nixosConfiguration
(among other outputs)

More here: https://nixos.wiki/wiki/Flakes
