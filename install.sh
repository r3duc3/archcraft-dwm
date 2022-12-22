#!/usr/bin/bash

if [ $USER != 'root' ]; then
	echo 'run as root please';
	exit 0;
fi

echo 'installing required packages (maybe)'
sudo pacman -S --needed --disable-download-timeout libx11 libxinerama libxft freetype2 pcmanfm geany rofi dunst maim xclip viewnior feh ksuperkey betterlockscreen xfce4-power-manager xorg-xsetroot xorg-xbacklight gpick ffmpeg xorg-xrandr dunst pamixer pulseaudio pulseaudio-alsa firefox xfce-polkit xfce4-clipman-plugin gpick

echo 'install some package'
mkdir -p /usr/share/archcraft
cp -rf archcraft/shared /usr/share/archcraft/dwm
chmod +x /usr/share/archcraft/dwm/bin/*
chmod +x /usr/share/archcraft/dwm/rofi/bin/*

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
make PREFIX=/usr install
cd ..

echo 'install dwm'
cd archcraft-dwm/source
make X11INC=/usr/include/X11 X11LIB=/usr/lib/X11 FREETYPEINC=/usr/include/freetype2
make PREFIX=/usr install