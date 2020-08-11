#!/bin/sh

# virt-manager
sudo pacman --noconfirm --needed -S virt-manager qemu ebtables dnsmasq bridge-utils openbsd-netcat edk2-ovmf
sudo systemctl enable --now libvirtd.service
sudo usermod -aG libvirt $USER
# VirtIO drivers: https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/

# Vagrant
sudo pacman --noconfirm --needed -S vagrant
vagrant plugin install vagrant-libvirt

# Docker
sudo pacman --noconfirm --needed -S docker-compose
sudo usermod -aG docker $USER

# Python
sudo pacman --noconfirm --needed -S python-pipenv

# Rust
sudo pacman --noconfirm --needed -S rust

# Markdown to PDF
sudo pacman --noconfirm --needed -S wkhtmltopdf
curl -s https://raw.githubusercontent.com/khuedoan/mdtopdf/master/mdtopdf > $HOME/.local/bin/mdtopdf
chmod +x $HOME/.local/bin/mdtopdf

# Cloud
sudo pacman --noconfirm --needed -S kubectl terraform
trizen --noconfirm --needed -S google-cloud-sdk
