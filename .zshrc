# zmodload zsh/zprof

HISTFILE=~/.zhistfile
HISTSIZE=50000
SAVEHIST=50000

fpath=(~/.zsh/site-functions $fpath)
fpath=(~/.zsh ~/.zfunc $fpath)
fpath=(/usr/local/share/zsh/site-functions $fpath)


source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh>/dev/null 2>&1
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh>/dev/null 2>&1
source ~/.zsh/zprofile.sh>/dev/null 2>&1
source ~/.zsh/zprofile.`uname`.sh>/dev/null 2>&1
source ~/.zsh/zprofile.local.sh>/dev/null 2>&1
source ~/.profile>/dev/null 2>&1
source ~/.zsh/zfunctions.sh>/dev/null 2>&1

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY

setopt appendhistory nomatch notify autocd auto_pushd
unsetopt beep
bindkey -e

zstyle ':completion:*:processes' command 'ps -xuf'
zstyle ':completion:*:processes' sort false
zstyle ':completion:*:processes-names' command 'ps xho command'

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' menu select
zstyle ':completion:*' use-compctl false

export WORDCHARS=''

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git

periodic() {
    GITBR=$(git branch --show-current 2>/dev/null | sed -E 's/^(.{10}).+$/\1.../')
    # GITBR=$(git branch --show-current 2>/dev/null | cut -c 1-10)
    [ ! -z $GITBR ] && GITBR=" [$GITBR]"
    # print -Pn "\033]0;`basename $PWD`$GITBR\007"
    vcs_info
    rehash
}

PERIOD=2

precmd() {
}

autoload -U colors && colors
zstyle ':vcs_info:git*' formats " %b %m%u%c"
zstyle ':vcs_info:git*' formats "%{$fg[blue]%}%b%{$fg[blue]%} %m%u%c%{$reset_color%}"
zstyle ':vcs_info:*' check-for-changes true
PROMPT=$' %{\e[1;34m%}%(5~|%-1~/.../%2~|%~) %{\e[1;34m%}%#%{\e[0m%} '
if [ -z $PROMPT_SUPPRESS_HOST ]; then
  PROMPT=' %m'$PROMPT
fi
# RPROMPT='%T'
RPROMPT='${vcs_info_msg_0_}'
if [[ $+MC_SID = 1 ]] ; then
        # inside Midnight Commander? Just give us a basic prompt
        PROMPT=">%(#/#/) "
        RPROMPT=""
fi

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='egrep --color=auto --text'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto'

alias sshh='ssh -o "StrictHostKeyChecking no"'
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias sudo='nocorrect sudo'
alias curl='noglob curl'

alias ll='ls -lh'
alias la='ls -a'
alias l='ls -lah'
alias lla='ls -lah'
alias du='du -h'
alias df='df -h'
alias -g G='|grep -E'
alias -g T='|tail'
alias -g H='|head'
alias -g L='|less'
alias -g J='|jq'
alias -g JL='|jq . | less'
alias -g C='|wc -l'
alias -g N='>/dev/null 2>&1'
alias -g XC='|xclip -i -sel clipboard'
alias -g xc='xclip -i -sel clipboard'
alias -g xo='xclip -o -sel clipboard'

alias cdp='popd'
alias gis='git status'

alias br='printf "=%.0s" {1..$(tput cols)}; echo'

bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word

bindkey '\e\eOC' forward-word
bindkey '\e\eOD' backward-word
bindkey '\e[5C' forward-word
bindkey '\e[5D' backward-word
bindkey '\e\e[C' forward-word
bindkey '\e\e[D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey "\e[1;3D" backward-word
bindkey "\e[1;3C" forward-word

bindkey '\e\e[D' backward-word
bindkey '\e\e[C' forward-word
bindkey '\e[7~'  beginning-of-line
bindkey '\e[8~'  end-of-line
bindkey '^[[1~'  beginning-of-line
bindkey '^[[4~'  end-of-line
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey '^[OA' history-beginning-search-backward
bindkey '^[OB' history-beginning-search-forward
bindkey '\e[3~' delete-char
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

bindkey "^[[3^" delete-word
bindkey "^[[3"  delete-word

export PATH=/usr/local/bin:$HOME/.local/bin:$HOME/.usr/bin:$HOME/.scripts:$PATH

bindkey "[3;5~"  delete-word
bindkey "[3;3~"  delete-word

# export LANG=en_US.UTF-8
export LANG=en_US.UTF-8

stty -ixon

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# zprof

export TERM=xterm-256color
