#!/bin/sh

#+---------+
#| Options |
#+---------+
erase_disk=0
disk='/dev/nvme0n1'
boot_partition="${disk}p1"
root_partition="${disk}p2"
encrypted_partition="/dev/mapper/encrypted"
mirrorlist_generator='https://www.archlinux.org/mirrorlist/?country=US&protocol=http&protocol=https&ip_version=4&use_mirror_status=on'
ucode='intel-ucode' # leave empty to disable ucode
swap_size='' # in GiB, leave empty to disable swap
hostname='arch' 
username='victor'
fullname='Victor Vo'
timezone='America/Los_Angeles'
bootloader='systemd-boot' # systemd-boot or efistub
