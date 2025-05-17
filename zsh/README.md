# ZSH

[`Zsh`](https://zsh.sourceforge.io/) is an extended version of `Bash` with a lot of useful features
such as improved tab completion.

I haven't spent a lot of time customizing this so there's
definitely space for improvements.

## Packages

- [`zinit`](https://github.com/zdharma-continuum/zinit) -
  Zsh plugin manager
- [`starship`](https://starship.rs/) -
  Customizable shell prompt configured [here](./../starship)
- [`zoxide`](https://github.com/ajeetdsouza/zoxide) -
  Smart version of the `cd` command
- [`fzf`](https://github.com/junegunn/fzf) -
  Command-line fuzzy finder

### Zinit

Zinit is a fast zsh plugin manager but
zsh plugins aren't manager dependent so you can use
whatever plugin manager you want.

You can update Zinit with `zinit self-update`

Currently I'm using these plugins:

- [`zsh-users/zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting) -
  Fish shell-like syntax highlighting
- [`zsh-users/zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions) -
  Fish shell-like autosuggestions
- [`zsh-users/zsh-completions`](https://github.com/zsh-users/zsh-completions) -
  Additional completion definitions
- [`jeffreytse/zsh-vi-mode`](https://github.com/jeffreytse/zsh-vi-mode) -
  Improved Vim mode
- [`Aloxaf/fzf-tab`](https://github.com/Aloxaf/fzf-tab) -
  Completion selection menu with `fzf`

And these snippets:

- [`git`](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git) -
  Adds aliases and useful functions for `git`
- [`command-not-found`](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/command-not-found) -
  Uses the default `command-not-found` package (distro specific)
  to suggest missing packages

## Files

Honestly I'm not really sure what the order is
as all of the articles (official or not) contradict themselves.
I would probably trust the
[StackOverflow answer](https://superuser.com/questions/1840395/complete-overview-of-bash-and-zsh-startup-files-sourcing-order)
the most.

What I've found:
- [StackOverflow answer](https://superuser.com/questions/1840395/complete-overview-of-bash-and-zsh-startup-files-sourcing-order)
- [Official Zsh introduction](https://zsh.sourceforge.io/Intro/intro_3.html#SEC3)
- [User's Guide to the Z-Shell](https://zsh.sourceforge.io/Guide/zshguide02.html#l9)

Update: I've found [the code](https://github.com/zsh-users/zsh/blob/fceece6a8a6a006b1ba546882aea10f9e03b0970/Src/init.c#L1444)
that probably does the script loading.

## Sources

The base for this configuration: https://www.youtube.com/watch?v=ud7YxC33Z3w

General zsh info: https://wiki.archlinux.org/title/Zsh

Old yet still useful guide to Z-Shell:
https://zsh.sourceforge.io/Guide/zshguide.html
