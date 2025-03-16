# Dotfiles (for Mac)

My collection of dotfiles for Mac.

The way I structured this repo is that each branch is named after the OS that the dotfiles are intended for. Natrually, `mac` and `linux`(comming soon) are almost exactly the same, but I want the flexability to tune these environments seperately as time goes on.

## Some Differences:

I expect to use `zsh` asdon Mac and `bash` on Linux. This is because I just use the default shell given to me.
- .zshrc <-> .bashrc

### Installation

```bash
git clone --branch mac https://github.com/nick-popovic/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow -t ~ -S . --override=.
```