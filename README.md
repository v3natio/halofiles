# Halofiles

![halofiles image](./halopicture.png)

- Settings for:
  - i3/i3status
  - vim/nvim (text editor)
  - zsh (shell)
  - lf (file manager)
  - mpv (video player)
  - other stuff like newsboat, sc-im, etc.

- I try to minimize what's directly in `~` so:
  - All configs that can be in `~/.config/` are.

## Install

You will need GNU `stow`.

Clone into your `$HOME` directory.

```bash
git clone https://github.com/Hooregi/Halofiles.git
```

Run `stow` to symlink everything, or just select whatever you need.

```bash
stow ./ # everything (the '/' ignores the README)
```

```bash
stow .config/zsh # just the zsh config
```

## Credit

Some of the scripts are from Luke Smith's [dotfiles](https://github.com/LukeSmithxyz/voidrice). Likewise, `zsh-functions` come from Chris Chiarulli's [dotfiles](https://github.com/ChristianChiarulli/Machfiles).
