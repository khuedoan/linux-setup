# Fork of khuedoan/linux-setup

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
curl -O https://raw.githubusercontent.com/nho1ix/linux-setup/master/base/install.sh
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

## Acknowledgements

- **kewlfft** for [Ansible module to manage packages from the AUR](https://github.com/kewlfft/ansible-aur)
- **Asif Mahmud** for [adding new SSH key to GitHub account](https://community.ibm.com/community/user/ibmz-and-linuxone/blogs/asif-mahmud1/2020/03/15/cloning-private-git-repository-using-ansible)
