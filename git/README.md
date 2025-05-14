# Git

This is a pretty customized git configuration
with some stuff that might not be for everyone
but that I find pretty useful.

This includes different diff algorithm,
branch and tag sorting, fetch/pull/push behavior
and more.

The most useful parts of this config are
probably the improved `git diff` and `git l` commands.

## Packages

- `git`
- [`diff-so-fancy`](https://github.com/so-fancy/diff-so-fancy)

`diff-so-fancy` provides a major improvement over the default diff viewer.

## Format

Git uses the basic `INI` format.

Sections are denoted by square brackets (`[section]`)
followed by some key-value pairs (`key = value`).

## Location

Git looks at these configuration files (in this order):

1) `/etc/gitconfig` (same as `git config --system`),
2) `~/.gitconfig` or `~/.gitconfig/git/config` (same as `git config --global`)
3) `.git/config` (same as `git config --local`)

The `git config` command actually writes into these configuration files.

## Sources

This is a good base git configuration:
https://github.com/codingjerk/dotfiles/blob/main/config/git/config

Great article that goes over what configuration options
the core git developers use (that isn't default but probably should be):
https://blog.gitbutler.com/how-git-core-devs-configure-git/


