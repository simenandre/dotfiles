# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Download Znap, if it's not there yet.
[[ -r ~/.zsh_repos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.zsh_repos/znap
source ~/.zsh_repos/znap/znap.zsh  # Start Znap
znap eval starship 'starship init zsh --print-full-init'
znap prompt

znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions

for file in ~/.{aliases,path,extras}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done

