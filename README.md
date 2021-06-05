# Linux Setup

## Supported distro

- [x] Arch Linux

## Features

- Install Arch Linux automatically (scripts in `./base`)
- Configure the newly installed system automatically:
  - Install my dotfiles and custom packages
  - Install system configuration files
  - And more

## Usage

After login for the first time, connect to the internet if needed (using `nmtui`), download and run the Ansible playbook:

```sh
git clone https://github.com/khuedoan/linux-setup.git
cd linux-setup
make
```

## Acknowledgements

- **kewlfft** for [Ansible module to manage packages from the AUR](https://github.com/kewlfft/ansible-aur)
- **Asif Mahmud** for [adding new SSH key to GitHub account](https://community.ibm.com/community/user/ibmz-and-linuxone/blogs/asif-mahmud1/2020/03/15/cloning-private-git-repository-using-ansible)
