#!/bin/sh

pacman --noconfirm -S efibootmgr intel-ucode networkmanager git gvim zsh

fallocate -l 32G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
vim /etc/fstab
echo "# Swap" >> /etc/fstab
echo "/swapfile none swap defaults 0 0" >> /etc/fstab

ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
hwclock --systohc
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen && locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
echo 'Precision' > /etc/hostname
efibootmgr -d /dev/nvme0n1 -p 1 -c -L "Arch Linux" -l /vmlinuz-linux -u 'initrd=/intel-ucode.img initrd=/initramfs-linux.img root=/dev/nvme0n1p2 rw quiet' -v
systemctl enable NetworkManager
echo "Changing root password"
passwd
useradd -m -G wheel -s /bin/zsh khuedoan
echo "Changing user password"
passwd khuedoan
visudo
