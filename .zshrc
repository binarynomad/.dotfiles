#
# .ZSHRC: This sets the environment for interactive shells. This gets loaded
# after .zprofile. It's typically a place where you "set it and forget it"
# type of parameters like $PATH, $PROMPT, aliases, and functions you would
# like to have in both login and interactive shells.
#

# ENV: Personal settings, aliases, functions, etc.
[ -f ~/.exports ] && source ~/.exports
[ -f ~/.functions ] && source ~/.functions
[ -f ~/.aliases ] && source ~/.aliases

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# OMZ: Path to installation.
export ZSH="${HOME}/.oh-my-zsh"

# OMZ: Fix for "Insecure completion-dependent directories detected"
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

# OMZ: Plugins
# Leaving out (git gh fzf) for now; test later -- BH
plugins=(
  colored-man-pages
  copypath
  dotenv
  rsync
  vi-mode
  z
)

# OMZ: Setup the enviroment, set after PLUGINS
source $ZSH/oh-my-zsh.sh

# User configuration

# ZSH: Custom Prompt to setup cursor on a newline
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

# ZSH: Syntax Highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ZSH: Autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# BREW/ZSH: Autocompletions
fpath+=/opt/homebrew/share/zsh/site-functions

# 1PW: CLI Autocompletion
eval "$(op completion zsh)"; compdef _op op

# BH: ZSH Completions
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/brian/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# FZF: Main import/setup of fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
