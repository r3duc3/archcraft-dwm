#!/usr/bin/env bash

## Copyright (C) 2020-2022 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3
## Autostart Programs

# Kill already running process
_ps=(picom dunst ksuperkey xfce-polkit xfce4-power-manager xfce4-clipman)
for _prs in "${_ps[@]}"; do
	if [[ `pidof ${_prs}` ]]; then
		killall -9 ${_prs}
	fi
done

# Fix cursor
xsetroot -cursor_name left_ptr

# Polkit agent
/usr/lib/xfce-polkit/xfce-polkit &

# Enable power management
xfce4-power-manager &

# Enable Super Keys For Menu
ksuperkey -e 'Super_L=Alt_L|F1' &

# Lauch dwmbar
/usr/share/archcraft/dwm/bin/dwmbar.sh &

# Lauch notification daemon
/usr/share/archcraft/dwm/bin/dwmdunst.sh

# Lauch compositor
#/usr/share/archcraft/dwm/bin/dwmcomp.sh

# Fix Java problems
wmname "LG3D"
export _JAVA_AWT_WM_NONREPARENTING=1

## Add your autostart programs here --------------
xfce4-clipman &
## -----------------------------------------------

# Launch DWM
while dwm; [ $? -ne 0  ]; do echo "start dwm"; done