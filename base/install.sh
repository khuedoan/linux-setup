
#!/bin/sh

#+---------+
#| Options |
#+---------+
if [[ ! -f config.sh ]]; then
    echo "Missing config.sh, downloading..."
    curl -O https://raw.githubusercontent.com/nho1ix/linux-setup/master/base/config.sh
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
    cgdisk "$disk"
fi
lsblk
sleep 5

# Format the boot partition
mkfs.fat -F32 "$boot_partition"

# Set up encryption
modprobe dm-crypt dm-mod
cryptsetup luksFormat -v -s 512 -h sha512 "$root_partition"
cryptsetup open "$root_partition" encrypted

# Format encrypted partition
mkfs.ext4 "$encrypted_partition"

# Mount the file systems
mount "$encrypted_partition" /mnt
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
sed -i '/^##/d' /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist
rm /etc/pacman.d/mirrorlist.backup

# Install base packages
pacstrap /mnt base linux linux-firmware base-devel linux-headers alsa-utils capitaine-cursors ccache chromium cpupower discord dunst earlyoom exa firefox firetools flex geeqie go gparted gufw htop khal lxappearance lxsession moc man-db man-pages otf-hermit pamixer pandoc pavucontrol powertop qalculate-gtk redshift ripgrep termdown thunderbird transmission-gtk tree ttf-font-awesome udiskie unclutter vim vim-ultisnips wget xorg-font-util xorg-fonts-100dpi xorg-fonts-75dpi xorg-server-devel xorg-xbacklight xorg-xev xorg-xfontsel xorg-xinput xorg-xsetroot zenity zsh

#+----------------------+
#| Configure the system |
#+----------------------+
genfstab -U /mnt >> /mnt/etc/fstab
if [[ ! -f chroot.sh ]]; then
    echo "Missing chroot.sh, downloading..."
    curl -O https://raw.githubusercontent.com/nho1ix/linux-setup/master/base/chroot.sh
fi
cat config.sh chroot.sh > /mnt/chroot.sh
chmod +x /mnt/chroot.sh
arch-chroot /mnt /chroot.sh
