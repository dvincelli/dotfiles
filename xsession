export ENV=$HOME/.kshrc
if [ -f "$HOME/.Xresources" ]; then
	xrdb -merge "$HOME/.Xresources"
fi
setxkbmap -option ctrl:nocaps

xsetroot -solid grey &
#xterm -bg black -fg white -fullscreen +sb -fs large &
xterm -fullscreen +sb &
cwm
