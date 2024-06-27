# Tricks

## Make CS2 use Wayland
Source: https://www.reddit.com/r/linux_gaming/comments/1ap67bh/counterstrike_2_how_to_native_wayland_support/

1. Go to `~/.steam/steam/steamapps/common/Counter-Strike Global Offensive/game`
2. Edit `cs2.sh` and change `export SDL_VIDEO_DRIVER=x11` to `export SDL_VIDEO_DRIVER=wayland`
