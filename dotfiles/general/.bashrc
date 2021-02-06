# clear the prompt a bit and work on
profiles=("$HOME/.bash_profile" "$HOME/.profile");

[[ -n "$PS1" ]]\
&& for p in $profiles; do
	[[ -f "$p" ]] && . "$p";
done;
