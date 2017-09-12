HISTFILE=~/.zhistfile
HISTSIZE=1000
SAVEHIST=1000

fpath=(~/.zsh/site-functions $fpath) 
# fpath+=~/.zfunc

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY

#setopt correctall

setopt appendhistory extendedglob nomatch notify autocd 
unsetopt beep
bindkey -e

zstyle ':completion:*:processes' command 'ps -xuf'
zstyle ':completion:*:processes' sort false
zstyle ':completion:*:processes-names' command 'ps xho command'

eval `dircolors`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' use-compctl false
zstyle :compinstall filename '/home/vladimir/.zshrc'

autoload -Uz compinit
compinit
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git 

precmd() {
    #tmux set -qg status-left "#S #P $(pwd)"
    #vcs_info
    rehash
}

autoload -U colors && colors
#zstyle ':vcs_info:git*' formats " %b %m%u%c"
zstyle ':vcs_info:git*' formats "%{$reset_color%}(%b%{$reset_color%} %m%u%c%{$reset_color%})"
zstyle ':vcs_info:*' check-for-changes true
PROMPT=$' %{\e[1;34m%}%(5~|%-1~/.../%2~|%~) ${vcs_info_msg_0_}%{\e[1;34m%}%#%{\e[0m%} '
RPROMPT='%T'

alias ls='ls --group-directories-first --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias sudo='nocorrect sudo'

alias ll='ls -lh'
alias la='ls -a'
alias l='ls -lah'
alias lla='ls -lah'
alias du='du -h'
alias df='df -h'
alias -g G='|grep'
alias -g T='|tail'
alias -g H='|head'
alias -g L='|less'
alias -g C='|wc -l'

alias gis='git status'
alias cal='ncal -b'


function markfile () {
    mv "$1" "_$1"
}

bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word
bindkey '\e[7~'  beginning-of-line
bindkey '\e[8~'  end-of-line
bindkey '^[[1~'  beginning-of-line
bindkey '^[[4~'  end-of-line
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '\e[3~' delete-char

export PATH=/home/vdimir/.local/bin:$PATH

# export LANG=en_US.UTF-8

stty -ixon
# eval $(thefuck --alias)

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
# eval "$(stack --bash-completion-script stack)"

export TERM=rxvt-unicode-256color

source "$HOME/minimal.zsh"



PROMPT=' $(minimal_path)$(minimal_vcs) $ '
RPROMPT='%T'
