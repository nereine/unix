# .bash_profile - bash-specific ENV

# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return;

# Wayland support - $WAYLAND is used by .config/shell/aliases, .config/dwm/dwmbar.sh, and sh-tools/bin/priv/firefox.sh.conf
[ "$XDG_SESSION_TYPE" = 'wayland' ]\
&& export WAYLAND=1\
&& export MOZ_ENABLE_WAYLAND=1;

# Load the shell dotfiles
shelld="$HOME/.config/shell";
bashconf=("$HOME/.profile" "$shelld/prompt-bash" "$shelld/aliases" "$shelld/paths");
for f in "${bashconf[@]}"; do
	[[ -f $f ]] && . $f || printf "%s: failed to source %s\n" "$0" "$f";
done;

# No persistent shell history
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups;
HISTCONTROL=ignoreboth;
unset HISTFILE;

# Window size
shopt -s checkwinsize;
