{ pkgs ? import <nixpkgs> { } }:
let
  libPath = with pkgs; lib.makeLibraryPath [
    libGL
    libxkbcommon
    wayland
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
    cmake
    alsa-lib
    binutils
    pkg-config
    wrapGAppsHook3
    glib
    glibc
    gsettings-desktop-schemas
    gtk3
    gtksourceview4
    librsvg
    libsndfile
    libxml2
    libzip
    pcre
    poppler
    portaudio
    zlib
    lua
  ];
in
with pkgs; mkShell {
  inputsFrom = [ ];
  buildInputs = [  gettext wrapGAppsHook3 glib portaudio cmake binutils alsa-lib cmake alsa-lib binutils glib gsettings-desktop-schemas gtk3 gtksourceview4 librsvg libsndfile libxml2 libzip pcre poppler portaudio zlib lua gtk3 cmake binutils rustup pkg-config python3  ];
  LD_LIBRARY_PATH = "${libPath}";
}
