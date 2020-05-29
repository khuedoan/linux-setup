#!/bin/sh

#+---------+
#| Options |
#+---------+
erase_disk=0
disk='/dev/nvme0n1'
boot_partition="${disk}p1"
root_partition="${disk}p2"
mirrorlist_generator='https://www.archlinux.org/mirrorlist/?country=SG&country=TH&country=VN&protocol=http&protocol=https&ip_version=4&use_mirror_status=on'
ucode='intel-ucode' # leave empty to disable ucode
swap_size='32G' # leave empty to disable swap
hostname='Precision' 
username='khuedoan'
fullname='Khue Doan'
timezone='Asia/Ho_Chi_Minh'
bootloader='systemd-boot' # systemd-boot or efistub
dotfiles_branch='master' # leave empty to disable dotfiles installation
