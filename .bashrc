#!/bin/bash

case $- in
*i*) ;;
*) return ;;
esac

# use a tty for gpg
# solves error: "gpg: signing failed: Inappropriate ioctl for device"
GPG_TTY=$(tty)
export GPG_TTY

# Shell
if [ -z "$SSH_AUTH_SOCK" ]; then
	eval $(ssh-agent -s)
	{
		/usr/bin/ssh-add -K
	} &>/dev/null
fi

{
	/usr/bin/ssh-add -K
} &>/dev/null

export VISUAL="nvim"

for file in ~/.{aliases,path,extras}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file
