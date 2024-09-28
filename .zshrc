# Created by newuser for 5.9
eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias vi=nvim

# If neofetch is installed
if command -v neofetch > /dev/null 2>&1; then
	DISPLAY="" neofetch
fi

# If fastfetch is installed
if command -v fastfetch > /dev/null 2>&1; then
	if [[ -o interactive ]]; then
		fastfetch
	fi
fi
