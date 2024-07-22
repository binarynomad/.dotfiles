#
# .ZPROFILE:  sets the environment for login shells; loaded before `.zshrc`

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(pyenv init --path)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
