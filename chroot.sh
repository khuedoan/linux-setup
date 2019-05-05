#!/bin/sh

pacman --noconfirm -S intel-ucode networkmanager git gvim zsh

fallocate -l 32G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "# swapfile" >> /etc/fstab
echo "/swapfile none swap defaults 0 0" >> /etc/fstab

ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
hwclock --systohc
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen && locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
echo 'Precision' > /etc/hostname

bootctl --path=/boot install
echo 'default arch' > /boot/loader/loader.conf
echo 'timeout 0' >> /boot/loader/loader.conf
echo 'editor  0' >> /boot/loader/loader.conf
echo 'title          Arch Linux' > /boot/loader/entries/arch.conf
echo 'linux          /vmlinuz-linux' >> /boot/loader/entries/arch.conf
echo 'initrd         /intel-ucode.img' >> /boot/loader/entries/arch.conf
echo 'initrd         /initramfs-linux.img' >> /boot/loader/entries/arch.conf
echo 'options        root=/dev/nvme0n1p2 rw quiet' >> /boot/loader/entries/arch.conf

systemctl enable NetworkManager
echo "Changing root password"
passwd
useradd -m -G wheel -s /bin/zsh khuedoan
echo "Changing user password"
passwd khuedoan
visudo
rm chroot.sh
