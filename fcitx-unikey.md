# Vietnamese Input Method Installation Guide

## Install neccessary packages:

`$ sudo pacman -S fcitx fcitx-unikey fcitx-im fcitx-configtool`

## Open `/etc/profile` to define the evironment variables:

`$ sudo nano /etc/profile`

Add these line to the bottom of the file:

>`# Fcitx`

>`export GTK_IM_MODULE=fcitx`

>`export QT_IM_MODULE=fcitx`

>`export XMODIFIERS=@im=fcitx`

Then log out and log back in.
