PATH=$PATH:/usr/local/bin
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export LS_COLORS="di=1;34:ln=36:so=35:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

alias ls='gls --group-directories-first --color=auto -v'

alias playping='afplay /System/Library/Sounds/Pop.aiff'
alias -g SND='&& afplay /System/Library/Sounds/Pop.aiff || afplay /System/Library/Sounds/Ping.aiff'

export HOMEBREW_NO_AUTO_UPDATE=1

export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"

# kitty + complete setup zsh | source /dev/stdin

alias ssh="TERM='xterm-256color' ssh"

alias yc_comp="source /Users/vdimir/yandex-cloud/completion.zsh.inc"

export DEVSERV=aws-dev
