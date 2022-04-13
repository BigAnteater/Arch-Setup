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
read USERNAME
sleep 2s
clear

# Installs DWM for the user.
echo "First we will be setting up DWM."
sleep 2s
cd "/usr/local"
git clone https://github.com/BigAnteater/dwm-config
cd "dwm-config"
bash install.sh
clear

# Installs applications for the user
echo "Now we will be installing the themes and applications."
sleep 2s
cd "/home/$USERNAME/"
pacman -S archlinux-keyring
pacman -S neovim thunar vlc htop fish --noconfirm
# Installs themes
mkdir .rice
cd .rice
git clone https://github.com/vinceliuice/Orchis-theme
cd Orchis-theme
./install -t purple -c dark --tweaks compact
cd "/home/$USERNAME/.rice/"
git clone https://github.com/vinceliuice/Tela-circle-icon-theme
cd Tela-circle-icon-theme
./install.sh purple
# Adds themes to the gtk config.
cd "/home/$USERNAME/.config/"
mkdir "gtk-3.0"
cd "gtk-3.0"
touch "settings.ini"
echo "[Settings]" > "settings.ini"
echo "gtk-theme-name = Orchis-purple-dark-compact" > "settings.ini"
echo "gtk-icon-theme-name = Tela-circle-purple-dark" > "settings.ini"
# Installs wallpaper themes.
cp -r "/home/$USERNAME/Arch-setup/wallpapers/" "/home/$USERNAME/.wallpapers/"
clear

# Installs fish shell settings.
echo "Unlike most people, I'm a weirdo so I use fish. So now you have to use my lame fish config too."
sleep 3s
rm -rf "/home/$USERNAME/.config/fish/"
cd "/home/$USERNAME/.config/"
cp -r "/home/$USERNAME/Arch-Setup/fish" "/home/$USERNAME/.config/"
chsh -s /bin/fish $USERNAME
clear

# Sets up pipewire.
echo "Finally, we will be setting up pipewire for audio."
sleep 3s
pacman -S pipewire wireplumber pipewire-alsa pipewire-pulse pipewire-jack pavucontrol --noconfirm
systemctl enable pipewire-pulse.service
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
fi if [ $REBOOT = n ]
	then
		echo "sounds good!"
		exit
fi
