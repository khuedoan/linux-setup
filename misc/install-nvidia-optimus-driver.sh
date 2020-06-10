#!/bin/sh

sudo pacman --noconfirm --needed -S nvidia lib32-nvidia-utils
trizen --noconfirm --needed -S optimus-manager

sudo sh -c "echo '## Allow members of group wheel to switch graphics card without a password' >> /etc/sudoers"
sudo sh -c "echo '%wheel ALL=(ALL) NOPASSWD: /usr/bin/prime-switch' >> /etc/sudoers"
