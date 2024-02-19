# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/cobraz/.oh-my-zsh"

ZSH_THEME="robbyrussell"

lugins=(git)

source $ZSH/oh-my-zsh.sh
if [[ -r "${HOME}/.bashrc" ]]; then
	# shellcheck source=/dev/null
	source "${HOME}/.bashrc"
fi


