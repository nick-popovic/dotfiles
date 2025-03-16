# Dotfiles (for Mac)

My collection of dotfiles for Mac.

The way I structured this repo is that each branch is named after the OS that the dotfiles are intended for. Natrually, `mac` and `linux`(comming soon) are almost exactly the same, but I want the flexability to tune these environments seperately as time goes on.

## Some Differences:

I expect to use `zsh` on Mac and `bash` on Linux. This is because I just use the default shell given to me.
- .zshrc <-> .bashrc

### Installation

```bash
git clone --branch mac-test https://github.com/nick-popovic/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod u+x dot_install.sh
./dot_install.sh
```

### A Note on `dot_install.sh` !!!
Please read through carefully how this script runs... it was written becauase I want to ensure I always have symlinks from `TARGET_DIR` to `DOTFILES_DIR` and could never figure out how to do this with the basic `stow` command. EXISTING FILES IN `TARGET_DIR` CONFLICTING WITH THOES IN `DOTFILES_DIR` WILL BE REPLACED AND TURNED INTO SYMLINKS POINTING TO `DOTFILES_DIR`. This script is not perfect, but it works for me. I am not responsible for any lost files.

If you want to use this repo and dont like or understand `dot_install.sh`, just use `stow` manually or whaterver you want :)
