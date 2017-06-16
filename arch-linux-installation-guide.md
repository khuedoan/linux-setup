<!--
Copyright © 2017 Khue Doan - All Rights Reserved
You may use, distribute and modify this code under the terms of the GNU GENERAL PUBLIC LICENSE license.
You should have received a copy of the GNU GENERAL PUBLIC LICENSE license with this file. If not, please visit https://www.gnu.org/licenses/gpl-3.0.en.html
-->

# Arch Linux Installation Guide

Installation guide and basic configurations for Arch Linux

## Verify the boot mode

Check if the directory exists:

`# ls /sys/firmware/efi/efivars`

## Connect to the internet

Connect to Wi-Fi network:

`# wifi-menu`

Check if internet connectivity is available:

`# ping -c 3 archlinux.org`

## Update the system clock

Ensure the system clock is accurate:

`# timedatectl set-ntp true`

Check the service status:

`# timedatectl status`

## Partition the disks

Identify disks:

`# lsblk`

Disks are assigned to a *block device* such as `/dev/nvme0n1`.

Clean the entire disk (**do not** do this if you want to keep your data):

* `# gdisk /dev/nvme0n1`
* `x` for extra functionality
* `z` to *zap* (destroy) GPT data structures and exit
* `y` to proceed
* `y` to blank out MBR

Create boot partition and root partition:

* `# cfdisk /dev/nvme0n1`
* Select `gpt`
* Hit `[   New   ]` to create a new patition
* Give the boot partition `1G` and let the rest for the root partition
* Select the boot partition and hit `[   Type   ]` to choose `EFI System`
* Hit `[   Write   ]` then type `yes` to save, then hit `[   Quit   ]`

## Format the partitions

Format the boot partition to FAT32:

`# mkfs.fat -F32 /dev/nvme0n1p1`

Format the root partition to ext4:

`# mkfs.ext4 /dev/nvme0n1p2`

## Mount the file systems

Mount root partition first:

`# mount /dev/nvme0n1p2 /mnt`

Then create mount point for boot partition and mount it accordingly:

`# mkdir /mnt/boot`

`# mount /dev/nvme0n1p1 /mnt/boot`

## Select the mirrors

Make a list of mirrors sorted by their speed then remove those from the list that are out of sync according to their [status](https://www.archlinux.org/mirrors/status/).

Backup the existing mirrorlist:

* `# cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup`

Rank the mirrors, output the *6* fastest mirrors:

* `# rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist`

## Install the base and base-devel packages

Use the **pacstrap** script:

`# pacstrap /mnt base base-devel`

## Generate an fstab file

Use `-U` or `-L` to define by UUID or labels:

`# genfstab -U /mnt >> /mnt/etc/fstab`

## Chroot

Change root to the new system:

`# arch-chroot /mnt`

## Create swap file

As an alternative to creating an entire swap partition, a swap file offers the ability to vary its size on-the-fly, and is more easily removed altogether.

Create a 32 GB (depend on your RAM) swap file:

`# fallocate -l 32G /swapfile`

Set the right permissions:

`# chmod 600 /swapfile`

format it to swap:

`# mkswap /swapfile`

Activate the swap file:

`# swapon /swapfile`

Edit fstab at `/etc/fstab` to add an entry for the swap file:

> /swapfile none swap defaults 0 0

## Configure time zone

Set your time zone by region:

`# ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime`

Generate `/etc/adjtime`:

`# hwclock --systohc`

## Configure locale

Uncomment `en_US.UTF-8 UTF-8` in `/etc/locale.gen`, then generate it:

`# locale-gen`

Set LANG variable in `/etc/locale.conf`:

> LANG=en_US.UTF-8

## Change host name

Create hostname file at `/etc/hostname` contain the host name, for example:
> ArchLinux

## Set your root password

`# passwd`

Enter your password then confirm it.

## Install boot loader

Install systemd-boot:

`# bootctl --path=/boot install`

Configure it in `/boot/loader/loader.conf` as you like, for example:

> default  arch
>
> timeout  0
>
> editor   0

And `/boot/loader/entries/arch.conf`:

> title          Arch Linux
>
> linux          /vmlinuz-linux
>
> initrd         /intel-ucode.img
>
> initrd         /initramfs-linux.img
>
> options        root=/dev/nvme0n1p2 rw

## Reboot

Exit the chroot environment by typing:

`# exit`

Optionally manually unmount all the partitions with:

`# umount -R /mnt`

Restart the machine:

`# reboot`

## Login

Login with your root account after the machine has rebooted.

## Add new user

Add a new user named `khuedoan`:

`# useradd -m -G wheel -s /bin/bash khuedoan`

Protect the newly created user `khuedoan` with a password:

`# passwd`

Establish nano as the **visudo** editor for the duration of the current shell session:

`# EDITOR=nano visudo`

Then uncomment `%wheel ALL=(ALL) ALL` to allow members of group `wheel` sudo access, uncomment `Defaults targetpw` and change it to `Defaults rootpw` to ask for the root password instead of the user password (then change the comment beside it accordingly).

## Service management

Show system status:

`# systemctl status`

List failed units:

`# systemctl --failed`

## Install pacaur

Logout if you are using the root account and login with `khuedoan`.

Install **git**:

`$ sudo pacman -S git`

Create an empty working directory named `Downloads`:

`$ mkdir Downloads && cd Downloads`


Clone the git repository of **cower**:

`$ git clone https://aur.archlinux.org/cower.git`

`$ cd cower`

Make the package and install it:

`$ makepkg -s --skippgpcheck`

`$ sudo pacman -U cower*.pkg.tar.xz`

Clone the git repository of **pacaur**:

`$ git clone https://aur.archlinux.org/pacaur.git`

`$ cd pacaur`

Make the package and install it:

`$ makepkg -s`

`$ sudo pacman -U pacaur*.pkg.tar.xz`

## Install zsh

See what shell is currently being used:

`$ echo $SHELL`

Install the **zsh** package:

`$ sudo pacman -S zsh zsh-completions`

Initial configuration:

`$ zsh`

List all installed shells:

`chsh -l`

Set **zsh** as default:

`chsh -s /bin/zsh`

Install **oh-my-zsh**:

`$ pacaur -S oh-my-zsh`
