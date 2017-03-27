#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/usr/local/etc/X11/xinit/.Xresources
sysmodmap=/usr/local/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d "$HOME/.Xresources.d" ] ; then
	for f in "$HOME/.Xresources.d/*" ; do
		xrdb -merge "$f"
	done
fi

# start some nice programs

if [ -d /usr/local/etc/X11/xinit/xinitrc.d ] ; then
	for f in /usr/local/etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

if [ -d /usr/share/fonts/artwiz-fonts ] ; then
	xset fp+ "/usr/share/fonts/artwiz-fonts/"
fi
exec startfluxbox
