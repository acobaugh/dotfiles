These are my $HOME dot files.

Usage
-----
```
$ sh dotfiles/install
BASE=/home/acobaugh/code.d/dotfiles
[gitconfig] Already exists and is not a symlink. Skipping.
[vimrc] /home/acobaugh/.vimrc -> /home/acobaugh/code.d/dotfiles/vimrc
```

With -f option to move existing files out of the way:
```
$ sh dotfiles/install -f
BASE=/home/acobaugh/code.d/dotfiles
[gitconfig] Moving ~/.gitconfig -> ~/.gitconfig.backup ; Symlinking ~/.gitconfig -> /home/acobaugh/code.d/dotfiles/gitconfig
[vimrc] /home/acobaugh/.vimrc -> /home/acobaugh/code.d/dotfiles/vimrc
```
