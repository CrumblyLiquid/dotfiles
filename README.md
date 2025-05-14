# Crumbly's Dotfiles

Here are pretty much all of my dotfiles!

I'm running NixOS and Arch Linux (btw.)
with Hyprland as my main window manager.
It's not `r/unixporn` worthy but
it's very functional.

Other than that I'm using
NeoVim for text editing
and zsh as my primary shell.

## Structure

Every folder represents one application (with some exceptions).
Inside are usually the configuration files for that application
and optionally a `default.nix` file for configuring the
application for my NixOS setup.

My NixOS setup is flake based, starting in `flake.nix`
with the rest being in `nix/` and `nix-solid/` folders.

## Installation

For most of the desktop configuration I'm
using [toml-bombadil](https://github.com/oknozor/toml-bombadil).

First install `toml-bombadil` then clone this repository and navigate into it.
To install the dotfiles run `bombadil install .` and `bombadil link --profiles liquid`

(I'm not really happy with how it works as it provides little feedback
but currently don't have the will to make patches or write my own)

## Documented parts

I'm trying to document most of my documentation
both for myself and others.

Documented:

- [x] [git](./git/README.md)
- [x] [keepassxc](./keepassxc/README.md)

Missing:

- [ ] zsh
- [ ] hypr
- [ ] waybar
- [ ] wezterm
- [ ] xournalpp
- [ ] scripts
- [ ] ssh
- [ ] starship
- [ ] clangd
- [ ] dunst
- [ ] nvim
- [ ] nix
- [ ] opentabletdriver
- [ ] tmux
- [ ] tofi
- [ ] bombadil.toml
