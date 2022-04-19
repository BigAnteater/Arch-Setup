#!/bin/bash

echo "This script will install my config files."
sleep 3s
clear

# Installs themes
echo "First we will be installing the GTK themes into ~/.themes" 
sleep 2s

mkdir ~/.themes
cd ~/.themes

# GTK Theme
git clone https://github.com/vinceliuice/Orchis-theme
cd Orchis-theme
bash install.sh -t purple

# GTK Icons Theme
git clone https://github.com/vinceliuice/Tela-circle-icon-theme
cd Tela-circle-icon-theme
bash install.sh purple


# Checks that ~/.config exists, then copies it over.
cd ~

if [ -d ".config" ]
then
        echo "looks like .config exists. Well I hope you don't mind me overwriting it."
	rm -rf .config
	cp -r ~/Arch-setup/config ~/.config
else
        echo "nope... creating .config"
	cp -r ~/Arch-setup/config/ ~/.config
fi

# Installs wallpaper themes.
cp -r ~/Arch-setup/wallpapers/ ~/.wallpapers

# Changes the shell for fish
echo "Finally, we will be making fish run as the default shell."
chsh -s /bin/fish

# Small talk
sleep 2s
echo "customization has been configured!"
clear
