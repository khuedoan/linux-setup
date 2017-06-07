# i3 Tiling Window Manager Installation And Customization Guide

Installation guide on Arch Linux with customization

## Install i3:

Install Xorg and i3:

`$ sudo pacman -S xorg xorg-xinit i3 dmenu`

Create a copy of the default `xinitrc` in home directory:

`$ cp /etc/X11/xinit/xinitrc ~/.xinitrc`

Edit `~/.xinitrc` and replace
    > twm &
    >
    > xclock -geometry50x50-1+1 &
    >
    > xterm -geometry 80x50+494+51 &
    >
    > xterm -geometry 80x20+494-0 &
    >
    > exec xterm -geometry 80x60+0+0 -name login

  with
