eval "$(starship init zsh)"

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS

ZSH="$HOME/.zsh"
alias ls='ls --color=auto'

source $ZSH/lib/history.zsh
source $ZSH/lib/key-bindings.zsh
source $ZSH/lib/grep.zsh
source $ZSH/lib/completion.zsh

source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/plugins/colored-man-pages/colored-man-pages.plugin.zsh
source $ZSH/plugins/history-substring-search/history-substring-search.zsh
autoload -Uz compinit
compinit
source $ZSH/plugins/git/git.plugin.zsh
source $ZSH/plugins/archlinux/archlinux.plugin.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
