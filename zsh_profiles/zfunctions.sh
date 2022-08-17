
function b () {
    echo "scale=3; $@" | bc
}
alias b='noglob b'

function venv () {
  CURDIR=`pwd`
  if [ ! -z "$1" ]; then
      cd "$1"
  fi
  ACTIVATEPATH="/bin/activate"
  VENVDIRS=("$@" "venv" ".venv" ".env")
  while [[ `pwd` != "/" ]]; do
    for DIR in $VENVDIRS; do
      FILE=$DIR$ACTIVATEPATH
      if [ -f $FILE ]; then
        echo "Activating venv."
        export PYTHONPATH=`pwd`
        source $FILE
        cd $CURDIR
        return
      fi
    done
    cd ..
  done
  echo "Virtual env not found."
  cd $CURDIR
}

function while_proc_exists () {
    if [ -z $1 ]; then
        echo usage: $0 pid
        return 1
    fi
    sleep_time=${2:-60s}
    exit_status=1
    while kill -0 $1; [ $? -eq 0 ]; do
        exit_status=0;
        sleep $sleep_time;
    done
    return $exit_status
}


function mkcd (){ mkdir -p -- "$1" && cd -P -- "$1"}

function termnotify (){ printf "\x1b]99;;${1:-ping}\x1b\\" }

alias git-up-master='git branch --show-current | grep -q master && (git pull upstream master --ff-only && git push origin) || echo "Not on master branch"'

