#!/usr/bin/bash

interval=0

## Wi-fi
wlan() {
	case "$(cat /sys/class/net/w*/operstate 2>/dev/null)" in
		up)
			CONNAME=$(nmcli -t -f STATE,CONNECTION device status | grep '^connected:' | sed 's/connected\://')
			printf "^c#3b414d^^b#7aa2f7^  ^d^%s" " ^c#7aa2f7^$CONNAME " ;;
		down) printf "^c#3b414d^^b#E06C75^ 睊 ^d^%s" " ^c#E06C75^Dc " ;;
	esac
}

## Time
clock() {
	printf "^c#1e222a^^b#668ee3^  "
	printf "^c#1e222a^^b#7aa2f7^ $(date '+%a, %d-%m-%y %H:%M:%S') "
}

## Battery Info
battery() {
	BAT=$(upower -i `upower -e | grep 'BAT'` | grep 'percentage' | cut -d':' -f2 | tr -d '%,[:blank:]')
	AC=$(upower -i `upower -e | grep 'BAT'` | grep 'state' | cut -d':' -f2 | tr -d '[:blank:]')

	if [[ "$AC" == "charging" ]]; then
		printf "^c#E49263^  $BAT%%"
	elif [[ "$AC" == "fully-charged" ]]; then
		printf "^c#E06C75^  Full"
	else
		if [[ ("$BAT" -ge "0") && ("$BAT" -le "20") ]]; then
			printf "^c#E98CA4^  $BAT%%"
		elif [[ ("$BAT" -ge "20") && ("$BAT" -le "40") ]]; then
			printf "^c#E98CA4^  $BAT%%"
		elif [[ ("$BAT" -ge "40") && ("$BAT" -le "60") ]]; then
			printf "^c#E98CA4^  $BAT%%"
		elif [[ ("$BAT" -ge "60") && ("$BAT" -le "80") ]]; then
			printf "^c#E98CA4^  $BAT%%"
		elif [[ ("$BAT" -ge "80") && ("$BAT" -le "100") ]]; then
			printf "^c#E98CA4^  $BAT%%"
		fi
	fi
}

## Main
while true; do
  sleep 1 && xsetroot -name "$(battery) $(wlan) $(clock)"
done
