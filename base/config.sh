#!/bin/sh

#+---------+
#| Options |
#+---------+
erase_disk=0
disk='/dev/nvme0n1'
boot_partition="${disk}p1"
root_partition="${disk}p2"
ucode='intel-ucode' # leave empty to disable ucode
swap_size='32' # in GiB, leave empty to disable swap
hostname='Precision' 
username='khuedoan'
fullname='Khue Doan'
timezone='Asia/Ho_Chi_Minh'
bootloader='systemd-boot' # systemd-boot or efistub
