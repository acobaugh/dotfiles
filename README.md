These are my $HOME dot files.

Usage
-----
```
$ sh install/update 
BASE=/home/phalenor/code.d/dotfiles
[gitconfig] Already exists and is not a symlink. Skipping.
[vimrc] /home/phalenor/.vimrc -> /home/phalenor/code.d/dotfiles/vimrc
```

With -f option to move existing files out of the way:
```
$ sh install/update -f
BASE=/home/phalenor/code.d/dotfiles
[gitconfig] Moving ~/.gitconfig -> ~/.gitconfig.backup ; Symlinking ~/.gitconfig -> /home/phalenor/code.d/dotfiles/gitconfig
[vimrc] /home/phalenor/.vimrc -> /home/phalenor/code.d/dotfiles/vimrc
```
