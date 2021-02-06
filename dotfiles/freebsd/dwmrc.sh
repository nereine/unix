#/bin/bash
xrdb -merge $HOME/.Xresources
compton --config /home/artnoi/.config/compton/compton.conf &
nitrogen --restore &
