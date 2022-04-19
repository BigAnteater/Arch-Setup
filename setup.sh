#!/bin/bash
# Thank you for using my arch config! I have commented the code below in case you plan on reading or editing it.
# I don't mind if you want to change around or re distribute my script with your own configs.

# Makes sure the user is running as root.
if [ $EUID -ne 0 ]
        then
                echo "This program must run as root to function." 
                exit 1
fi

# Little introduction.
echo "This script will assist you with setting up my Arch config."
sleep 2s
clear

# Asks for user confirmation.
echo "are you sure you would like to continue with my setup? y/n"
read CONFIRM
if [ $CONFIRM = n ]
	then
		exit
fi
sleep 1s
clear

# Installs DWM for the user.
echo "First we will be setting up DWM."
sleep 2s
pacman -S xorg lightdm lightdm-gtk-greeter gtk3 gtk2 neovim thunar vlc htop fish archlinux-keyring --noconfirm
systemctl enable lightdm
cd "/usr/local"
git clone https://github.com/BigAnteater/dwm-config
cd "dwm-config"
bash install.sh
clear

# Installs fish shell settings.
echo "Unlike most people, I'm a weirdo so I use fish. So now you have to use my lame fish config too."
sleep 3s
pacman -S fish --noconfirm
clear

# Sets up pipewire.
echo "Finally, we will be setting up pipewire for audio."
sleep 3s
pacman -S pipewire wireplumber pipewire-alsa pavucontrol --noconfirm
sleep 2s
clear

# Outro and reboot prompt
echo "You have successfully installed my config! Now you should reboot. y/n"
read REBOOT
if [ $REBOOT = y ]
	then
		echo "rebooting..."
		sleep 5s
		reboot
fi
