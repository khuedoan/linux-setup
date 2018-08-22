<!--
Copyright © 2017 Khue Doan - All Rights Reserved
You may use, distribute and modify this code under the terms of the GNU GENERAL PUBLIC LICENSE license.
You should have received a copy of the GNU GENERAL PUBLIC LICENSE license with this file. If not, please visit https://www.gnu.org/licenses/gpl-3.0.en.html
-->

# Bumblebee Installation Guide

## Install the necessary packages:

`$ sudo pacman -S bumblebee mesa xf86-video-intel nvidia lib32-nvidia-utils lib32-virtualgl nvidia-settings bbswitch`

## Add user to `bumblebee` and `video` group:

`$ sudo gpasswd -a $USER bumblebee`

`$ sudo gpasswd -a $USER video`

# Start bumblebee at boot:

`$ sudo systemctl enable bumblebeed.service`

# Restart the system:

`$ sudo shutdown -r now`

# Edit NVIDIA desktop icon to run with bumblebee:

`$ sudo nano /usr/share/applications/nvidia-settings.desktop`

At `Exec=/usr/bin/nvidia-settings` line change it to:

> Exec=optirun -b none /usr/bin/nvidia-settings -c :8
