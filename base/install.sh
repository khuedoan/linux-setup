#!/bin/sh

#+---------+
#| Options |
#+---------+
if [[ ! -f config.sh ]]; then
    echo "Missing config.sh, downloading..."
    curl -O https://raw.githubusercontent.com/khuedoan/linux-setup/master/base/config.sh
fi
vim ./config.sh
source ./config.sh

#+------------------+
#| Pre-installation |
#+------------------+
# Update the system clock
timedatectl set-ntp true

# Partition the disk
if [ "$erase_disk" -eq 1 ]; then
    # 1GiB for /boot and the rest for /
    sgdisk -Z "$disk"
    fdisk "$disk" << \
EOF
g
n


+1GiB
t
1
n



w
EOF
else
    cfdisk "$disk"
fi
lsblk
sleep 5

# Format the partitions
mkfs.fat -F32 "$boot_partition"
mkfs.ext4 "$root_partition"

# Mount the file systems
mount "$root_partition" /mnt
mkdir /mnt/boot
mount "$boot_partition" /mnt/boot

#+--------------+
#| Installation |
#+--------------+

# Install base packages
pacstrap /mnt base linux linux-firmware base-devel

#+----------------------+
#| Configure the system |
#+----------------------+
genfstab -U /mnt >> /mnt/etc/fstab
if [[ ! -f chroot.sh ]]; then
    echo "Missing chroot.sh, downloading..."
    curl -O https://raw.githubusercontent.com/khuedoan/linux-setup/master/base/chroot.sh
fi
cat config.sh chroot.sh > /mnt/chroot.sh
chmod +x /mnt/chroot.sh
arch-chroot /mnt /chroot.sh
