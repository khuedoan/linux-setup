#!/bin/sh

#+---------+
#| Options |
#+---------+
erase_disk=1
disk='/dev/nvme0n1'
boot_partition="${disk}p1"
root_partition="${disk}p2"
ucode='intel-ucode' # leave empty to disable ucode
swap_size='32G' # leave empty to disable swap
hostname='Precision' 
rootpasswd=''
username='khuedoan'
fullname='Khue Doan'
userpasswd=''
bootloader='systemd-boot' # systemd-boot or efistub
timezone='Asia/Ho_Chi_Minh'
mirrorlist_generator='https://www.archlinux.org/mirrorlist/?country=SG&country=TH&country=VN&protocol=http&protocol=https&ip_version=4&use_mirror_status=on'

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
# Select the mirrors
pacman -Syy
pacman --noconfirm --needed -S pacman-contrib
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
curl "$mirrorlist_generator" > /etc/pacman.d/mirrorlist.backup
sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
rankmirrors -n 5 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
sed '/^##/d' /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist
rm /etc/pacman.d/mirrorlist.backup

# Install base packages
pacstrap /mnt base base-devel

#+----------------------+
#| Configure the system |
#+----------------------+
genfstab -U /mnt >> /mnt/etc/fstab
curl https://khuedoan.me/archguide/chroot.sh > chroot.sh
chmod +x chroot.sh
cp chroot.sh /mnt
arch-chroot /mnt /chroot.sh
