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

# Asks for the user's username.
echo "What is your username?"
read currentUser
sleep 2s
clear

# Installs DWM for the user.
echo "First we will be setting up DWM."
mkdir "/home/$currentUser/.config/"
sleep 2s
pacman -S xorg lightdm lightdm-gtk-greeter --noconfirm
systemctl enable lightdm
cd "/usr/local"
git clone https://github.com/BigAnteater/dwm-config
cd "dwm-config"
bash install.sh
clear

# Installs applications for the user
echo "Now we will be installing the themes and applications."
sleep 2s
cd "/home/$currentUser/"
pacman -S archlinux-keyring
pacman -S neovim thunar vlc htop fish --noconfirm
# Installs themes
mkdir .rice
cd .rice
git clone https://github.com/vinceliuice/Orchis-theme
cd Orchis-theme
bash install.sh -t purple
cd "/home/$currentUser/.rice/"
git clone https://github.com/vinceliuice/Tela-circle-icon-theme
cd Tela-circle-icon-theme
bash install.sh purple
# Adds themes to the gtk config.
cd "/home/$currentUser/.config/"
mkdir "gtk-3.0"
cd "gtk-3.0"
touch settings.ini
echo -e '[Settings]\ngtk-theme-name = Orchis-purple-dark-compact\ngtk-icon-theme-name = Tela-circle-purple-dark'  settings.ini
# Installs wallpaper themes.
clear

# Installs fish shell settings.
echo "Unlike most people, I'm a weirdo so I use fish. So now you have to use my lame fish config too."
sleep 3s
rm -rf "/home/$currentUser/.config/fish/"
cd "/home/$currentUser/.config/"
cp -r "/home/$currentUser/Arch-Setup/fish" "/home/$currentUser/.config/"
chsh -s /bin/fish $currentUser
clear

# Sets up pipewire.
echo "Finally, we will be setting up pipewire for audio."
sleep 3s
pacman -S pipewire wireplumber pipewire-alsa pavucontrol --noconfirm
sleep 2s
clear

# Confirms that everything in the home folder isn't messed up
chown -R $currentUser /home/$currentUser

# Outro and reboot prompt
echo "You have successfully installed my config! Now you should reboot. y/n"
read REBOOT
if [ $REBOOT = y ]
	then
		echo "rebooting..."
		sleep 5s
		reboot
fi
