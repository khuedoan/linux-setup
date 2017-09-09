sudo pacman -S bumblebee mesa xf86-video-intel nvidia lib32-nvidia-utils lib32-virtualgl nvidia-settings bbswitch

sudo gpasswd -a $USER bumblebee

sudo gpasswd -a $USER video

sudo systemctl enable bumblebeed.service

sudo shutdown -r now

optirun -b none nvidia-settings -c :8
