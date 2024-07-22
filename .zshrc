#
# .ZSHRC: This sets the environment for interactive shells. This gets loaded
# after .zprofile. It's typically a place where you "set it and forget it"
# type of parameters like $PATH, $PROMPT, aliases, and functions you would
# like to have in both login and interactive shells.
#

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/brian/.oh-my-zsh"

ZSH_DISABLE_COMPFIX="true"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#
# 2023-09-13: Removed GIT for now
plugins=(
  colored-man-pages
  copypath
  fzf
  jsontools
  nmap
  sudo
  vi-mode
  web-search
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
   export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

###########################################################
# BH: Personal Settings
###########################################################

# BRIAN: Personal settings, aliases, functions, etc.
[ -f ~/.exports ] && source ~/.exports
[ -f ~/.functions ] && source ~/.functions
[ -f ~/.aliases ] && source ~/.aliases

# BRIAN: ZSH Prompt on NewLine
precmd() { print "" }
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
      print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
      print -n "%{%k%}"
  fi

  print -n "%{%f%}"
  CURRENT_BG=''
  #Adds the new line and ➜ as the start character.
  printf "\n$";
}

# BRIAN: TheFuck
eval $(thefuck --alias doh)

# BRIAN: Z Directory Jumping
. /opt/homebrew/etc/profile.d/z.sh

# BRIAN: ZSH Syntax
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# BRIAN: ZSH Autocompletion
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# BRIAN: BREW ZSH Autocompletions
fpath+=/opt/homebrew/share/zsh/site-functions

# BRIAN: FZF source commands
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# BRIAN: 1PASSWORD CLI Autocompletion
eval "$(op completion zsh)"; compdef _op op

# BRIAN: 1PASSWORD CLI Plugins
source /Users/brian/.config/op/plugins.sh

# BRIAN: ZSH Completions
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/brian/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# BRIAN: PYENV Enviroment Setup
if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init -)"
fi

# ITERM: Shell Integration as of (2024-05-25)
test -e /Users/brian/.iterm2_shell_integration.zsh && source /Users/brian/.iterm2_shell_integration.zsh || true
