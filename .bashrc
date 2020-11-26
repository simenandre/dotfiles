#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

# Start the gpg-agent if not already running
# if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
# 	gpg-connect-agent /bye >/dev/null 2>&1
# fi
# gpg-connect-agent updatestartuptty /bye >/dev/null

# use a tty for gpg
# solves error: "gpg: signing failed: Inappropriate ioctl for device"
GPG_TTY=$(tty)
export GPG_TTY

# Set SSH to use gpg-agent
# unset SSH_AGENT_PID
# if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
# 	if [[ -z "$SSH_AUTH_SOCK" ]] || [[ "$SSH_AUTH_SOCK" == *"apple.launchd"* ]]; then
# 		SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
# 		export SSH_AUTH_SOCK
# 	fi
# fi

# Shell
if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s`
    /usr/bin/ssh-add -K
fi

/usr/bin/ssh-add -K

# TODO: Fix /dev/fd/13:type:12979: bad option: -t issue
# source kubectl bash completion
# if hash kubectl 2>/dev/null; then
# 	# shellcheck source=/dev/null
# 	source <(kubectl completion bash)
# fi

# Set Emacs as VISUAL
export VISUAL="emacs"

for file in ~/.{aliases,path,extras}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
