# Halofiles

![halofiles image](./halopicture.png)

- All purpose scripts are in `~/.local/bin`.

- Settings for:

  - yazi (file manager)
  - mpv (video player)
  - nvim (text editor)
  - zsh (shell)
  - other stuff like newsboat, nsxiv, etc.

- I try to minimize what's directly in `~` so:
  - Conforming to the [XDG](https://wiki.archlinux.org/title/XDG_Base_Directory) specification is crucial.
  - All configs that can be in `~/.config/` are.
  - Environment variables are set in `~/.zprofile`.

## Install

You will need GNU `stow`.

Clone into your `$HOME` directory.

```bash
git clone https://github.com/v3natio/halofiles.git
```

Run `stow` to symlink everything, or just select whatever you need.

```bash
stow . # everything (.stow-ignore is in place to prevent pulling the LICENSE, README, etc)
```

```bash
stow .config/zsh # just the zsh config
```
