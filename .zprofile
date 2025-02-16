#
# .ZPROFILE:  sets the environment for login shells; loaded before `.zshrc`

# HOMEBREW: Env setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# ITERM: Shell Integration as of (2024-05-25)
test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh || true

# 1PW: CLI Env for Plugins
source ${HOME}/.config/op/plugins.sh

# FZF: Env setup -- installed via .vimrc plugin 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# PYENV: Enviroment Setup
if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init -)"
fi

# PYENV: Env setup
eval "$(pyenv init --path)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi


# added by Snowflake SnowSQL installer v1.2
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
