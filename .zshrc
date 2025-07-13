# Created by newuser for 5.9
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Override
alias vi=nvim
alias vim=nvim

# If neofetch is installed
if command -v neofetch > /dev/null 2>&1; then
	DISPLAY="" neofetch
fi

# If fastfetch is installed
if command -v fastfetch > /dev/null 2>&1; then
    if command -v pokemon-colorscripts > /dev/null 2>&1; then
        fastfetch --data-raw "$(pokemon-colorscripts -r)" 
    else
        fastfetch
    fi
fi

# macOS
if ([[ $(uname) == "Darwin" ]]); then
	source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if ([[ $(uname) == "Linux" ]]); then
	source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Cargo
# export PATH="$HOME/.cargo/bin:$PATH"

# Go
export GOPATH=$(go env GOPATH)
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# Kinda replaces the native ls command
alias ll="eza -l --icons"
alias ls="eza --icons"
alias ll="eza -l --icons"
alias la="eza -la --icons"

export LC_NUMERIC=en_US.UTF-8
