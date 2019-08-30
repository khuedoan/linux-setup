#!/bin/sh

# Options
erase_disk=1
disk='nvme0n1'
boot_partition='p1'
root_partition='p2'
ucode='intel-ucode' # leave empty to disable ucode
swap_size='32G' # leave empty to disable swap
hostname='Precision' 
rootpasswd=''
username='khuedoan'
fullname='Khue Doan'
userpasswd=''
bootloader='systemd-boot' # systemd-boot or efistub
timezone='Asia/Ho_Chi_Minh'

# Select the mirrors
vim /etc/pacman.d/mirrorlist

# Update the system clock
timedatectl set-ntp true

# Partition the disk
if [ "$erase_disk" -eq 1 ]; then
    sgdisk -Z /dev/"$disk"
    fdisk /dev/"$disk" << \
EOF
g
n


+1GiB
n



w
EOF
else
    cfdisk /dev/"$disk"
fi
lsblk
sleep 5

# Format the partitions
mkfs.fat -F32 /dev/"$disk$boot_partition"
mkfs.ext4 /dev/"$disk$root_partition"

# Mount the file systems
mount /dev/"$disk$root_partition" /mnt
mkdir /mnt/boot
mount /dev/"$disk$boot_partition" /mnt/boot

# Install base packages
pacstrap /mnt base base-devel

# Configure the system
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt << \
EOF
pacman --noconfirm -S $ucode networkmanager git gvim zsh

if [ -n "$swap_size" ]; then
    fallocate -l $swap_size /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo "# swapfile" >> /etc/fstab
    echo "/swapfile none swap defaults 0 0" >> /etc/fstab
fi

ln -sf /usr/share/zoneinfo/$timezone /etc/localtime
hwclock --systohc
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen && locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
echo "$hostname" > /etc/hostname

if [ "$boot_loader" = "systemd-boot" ]; then
    bootctl --path=/boot install
    echo 'default arch' > /boot/loader/loader.conf
    echo 'timeout 0' >> /boot/loader/loader.conf
    echo 'editor  0' >> /boot/loader/loader.conf
    echo 'title   Arch Linux' > /boot/loader/entries/arch.conf
    echo 'linux   /vmlinuz-linux' >> /boot/loader/entries/arch.conf
    [ -n "$ucode" ] && echo 'initrd  /intel-ucode.img' >> /boot/loader/entries/arch.conf
    echo 'initrd  /initramfs-linux.img' >> /boot/loader/entries/arch.conf
    echo "options root=/dev/$disk$root_partition rw quiet" >> /boot/loader/entries/arch.conf
elif [ "$boot_loader" = "efistub" ]; then
    [ -n "$ucode" ] && ucode_init="initrd=/$ucode.img"
    efibootmgr -d /dev/$disk -p 1 -c -L "Arch Linux" -l /vmlinuz-linux -u "$ucode_init initrd=/initramfs-linux.img root=/dev/$disk$root_partition rw quiet" -v
fi

sed -i 's/^HOOKS=(base udev/HOOKS=(base systemd/g' /etc/mkinitcpio.conf
mkinitcpio -p linux
echo "StandardOutput=null\nStandardError=journal+console" | SYSTEMD_EDITOR="tee -a" systemctl edit --full systemd-fsck-root.service

systemctl enable NetworkManager
echo "Changing root password"
passwd
$rootpasswd
$rootpasswd
useradd -m -G wheel -s /bin/zsh -c "$fullname" "$username"
echo "Changing user password"
passwd "$username"
$userpasswd
$userpasswd
visudo
sed -i 's/^#Color/Color/g' /etc/pacman.conf
vim /etc/pacman.conf
pacman -Syy
EOF
