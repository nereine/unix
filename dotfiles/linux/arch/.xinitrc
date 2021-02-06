[[ -f $HOME/.Xresources ]] && xrdb $HOME/.Xresources &

# Set default wm here
[ -z "$wm" ] && wm="bsp"

case "$wm" in
	'ob')
		openbox-session ;;
	'bsp')
		bspwm ;;
	'dwm')
		# Start compositor etc.
		. $HOME/.config/dwm/autostart.sh &
		# Use 'xsetroot' to emulate menu bar
		. $HOME/.config/dwm/dwmbar.sh &
		exec dwm ;;
esac
