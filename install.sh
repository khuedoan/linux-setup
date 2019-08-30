#!/bin/sh

# Options
erase_disk=1
disk='nvme0n1'
boot_partition='p1'
root_partition='p2'

# Select the mirrors
vim /etc/pacman.d/mirrorlist

# Update the system clock
timedatectl set-ntp true

# Partition the disk
if [ "$erase_disk" -eq 1 ]; then
    sgdisk -Z /dev/"$disk"
    fdisk -u -p /dev/"$disk" << \
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
curl https://khuedoan.me/archguide/chroot.sh > chroot.sh
chmod +x chroot.sh
cp chroot.sh /mnt
arch-chroot /mnt /chroot.sh
