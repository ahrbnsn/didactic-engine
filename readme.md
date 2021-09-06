Potential rough spots:

- not clear on differentiation between setup repo & dotfiles repo. there is a distinction, i just need to nail it down

- vim-plug is not tracked in dotfiles.  ie $HOME/.local/.share/nvim not tracked

on initial setup, should run:

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

- fonts are rough.
current selection: dank mono. very nice. 


