#!/usr/bin/bash

echo 'installing required packages (maybe)'
sudo pacman -S --needed --disable-download-timeout libx11 libxinerama libxft freetype2 pcmanfm geany rofi dunst maim xclip viewnior feh ksuperkey betterlockscreen xfce4-power-manager xorg-xsetroot xorg-xbacklight gpick ffmpeg xorg-xrandr dunst pamixer pulseaudio pulseaudio-alsa firefox xfce-polkit xfce4-clipman-plugin gpick

echo 'install some package'
sudo mkdir -p /usr/share/archcraft
sudo cp -rf archcraft/shared /usr/share/archcraft/dwm
sudo chmod +x /usr/share/archcraft/dwm/bin/*
sudo chmod +x /usr/share/archcraft/dwm/rofi/bin/*

git clone https://github.com/archcraft-os/archcraft-packages.git

cd archcraft-packages/
for x in 'dunst-icons/' '/fonts/' 'scripts'; do
	cd archcraft-$x;
	makepkg -is
	cd ..
done
cd ..

echo 'install st'
cd archcraft-st
patch --forward --strip=1 --input="anysize.patch"
patch --forward --strip=1 --input="st-boxdraw.patch"
patch --forward --strip=1 --input="st-mouse-scroll_1.patch"
patch --forward --strip=1 --input="st-mouse-scroll_2.patch"
patch --forward --strip=1 --input="st-mouse-scroll_3.patch"
make X11INC=/usr/include/X11 X11LIB=/usr/lib/X11
sudo make PREFIX=/usr install
cd ..

echo 'install dwm'
cd archcraft-dwm/source
make X11INC=/usr/include/X11 X11LIB=/usr/lib/X11 FREETYPEINC=/usr/include/freetype2
sudo make PREFIX=/usr install
