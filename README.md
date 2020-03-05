# Dotfiles

## Install

Prereqs: `brew install stow`

```
cd && mkdir -p pwm  && cd pwm
git clone git@github.com:padwasabimasala/dotfiles.git && cd dotfiles
stow -t $HOME .
```
