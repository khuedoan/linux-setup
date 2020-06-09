#!/bin/sh

email=$(whiptail --inputbox "Enter email for SSH key" 10 20 3>&1 1>&2 2>&3)
ssh-keygen -t rsa -b 4096 -C "${email}"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

dotfiles remote set-url origin git@github.com:khuedoan98/dotfiles.git
