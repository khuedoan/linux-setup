# Linux Setup

## Supported distro

- [x] Arch Linux

## Features

- Install Arch Linux automatically (scripts in `./base`)
- Configure the newly installed system automatically:
    - Install my dotfiles and custom packages
    - Install NVIDIA driver with `optimus-manager` if needed
    - Install system configuration files
    - And more

## Usage

### Install script

Boot to Arch Linux live USB and connect to the internet (using `iwctl` if you're on WiFi), then download and run the install script:

```sh
curl -O https://raw.githubusercontent.com/khuedoan/linux-setup/master/base/install.sh
chmod +x install.sh
```

The config file will show up, edit it according to your needs.

After the installation process finished, reboot the system.

### Ansible playbook

After login for the first time, connect to the internet (using `nmtui`), download and run the Ansible playbook:

```sh
git clone https://github.com/khuedoan/linux-setup.git
cd linux-setup
ansible-playbook --ask-vault-pass --ask-become-pass playbook.yml
```
