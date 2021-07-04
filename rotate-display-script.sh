#!/bin/bash
tvar="$(xfconf-query -c displays -p /Default/DisplayPort-2/Rotation)"
if [[ -z $tvar ]]; then
	echo "Failure: empty tvar"
	exit 1
elif [[ "$tvar" == "0" ]]; then # Currently landscape, rotate to portrait
	# Rotate display
	xrandr --output DisplayPort-2 --rotate left
	# Reposition second display
	xrandr --output HDMI-A-0 --pos 1440x1480
	# Set xfconf settings to make setting persist
	xfconf-query -c displays -p /Default/HDMI-A-0/Position/X -t int -s 1440
	xfconf-query -c displays -p /Default/HDMI-A-0/Position/Y -t int -s 1480
	xfconf-query -c displays -p /Default/DisplayPort-2/Rotation -t int -s 90
	# Change wallpaper
	xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorDisplayPort-2/workspace0/last-image -t string -s /home/death/pictures/wallpapers/tall.jpg
else # Not landscape, hopefully portrait, rotate to landscape
	# Rotate display
	xrandr --output DisplayPort-2 --rotate normal
	# Reposition second display
	xrandr --output HDMI-A-0 --pos 2560x360
	# Set xfconf settings to make setting persist
	xfconf-query -c displays -p /Default/HDMI-A-0/Position/X -t int -s 2560
	xfconf-query -c displays -p /Default/HDMI-A-0/Position/Y -t int -s 360
	xfconf-query -c displays -p /Default/DisplayPort-2/Rotation -t int -s 0
	# Change wallpaper
	xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorDisplayPort-2/workspace0/last-image -t string -s /home/death/pictures/wallpapers/wide.jpg
fi
# Reset mouse cursor size
xfconf-query -c xsettings -p /Gtk/CursorThemeSize -t int -s 16
