PATH=$PATH:/usr/local/bin
PATH=$PATH:/opt/homebrew/bin

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

PATH="$(brew --prefix)/opt/findutils/libexec/gnubin:$(brew --prefix)/opt/grep/libexec/gnubin:$PATH"
PATH="${HOME}/Library/Python/3.8/bin/:$PATH"

source $(brew --prefix zsh-syntax-highlighting)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# https://geoff.greer.fm/lscolors/
export LS_COLORS='di=1;34:ln=36:so=1;32:pi=1;33:ex=35:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
export LSCOLORS=ExgxCxDxfxegedabagacad
export CLICOLOR=1
# alias ls='gls --group-directories-first --color=auto -v'

alias playping='afplay /System/Library/Sounds/Pop.aiff'
alias -g SND='&& afplay /System/Library/Sounds/Pop.aiff || afplay /System/Library/Sounds/Ping.aiff'

export HOMEBREW_NO_AUTO_UPDATE=1

export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"

# kitty + complete setup zsh | source /dev/stdin

alias ssh="TERM='xterm-256color' ssh"

export DEVSERV=aws-dev

PROMPT_SUPPRESS_HOST=1
export GPG_TTY=$(tty)

alias subl="vscode -n"
