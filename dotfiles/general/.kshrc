# Wayland support
# $WAYLAND is used in .config/shell/aliases and .config/dwm/dwmbar.sh
[ "$XDG_SESSION_TYPE" = 'wayland' ]\
&& export WAYLAND=1\
&& export MOZ_ENABLE_WAYLAND=1;

shelld="$HOME/.config/shell"
set -A shellf "$shelld/paths" "$shelld/aliases" "$shelld/prompt-ksh";
for f in "${shellf[@]}"; do
	. $f || printf "%s: failed to source - %s\n" "$0" "$f";
done
