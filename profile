#!/usr/bin/env bash

export PATH=/usr/local/bin/gold/:/usr/lib/ccache:~/bin:$PATH
#adding depot_tools
export PATH=~/Work/kapowcef/depot_tools:$PATH
# ccache support
export CCACHE_HARDLINK=1
#export CCACHE_PREFIX=distcc
export CCACHE_SLOPPINESS=time_macros
export CCACHE_LOGFILE=/tmp/ccache.log
export CCACHE_CPP2=yes

#linux sandbox
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox

function build-notify {
  if [ $? -eq 0 ]; then
    notify-send -i weather-clear 'Success!' 'Back to work!'
  else
    notify-send -i weather-showers 'Failed!' 'What happened?'
  fi
}

alias mk='make -j8; build-notify'
alias bk='./kapow-build; build-notify'
alias ninjad='ninja -C out/Debug -v'
#prompt
emoji=(😄 😃 😀 😊 ☺ 😉 😍 😘 😚 😗 😙 😜 😝 😛 😳 😁 😔 😌 😒 😞 😣 😢 😂 😭 😪 😥 😰 😅 😓 😩 😫 😨 😱 😠 😡 😖 😆 😋 😷 😎 😴 😵 😲 😟 😦 😧 😈 😮 😐 😕 😯 😶 😇 😏 😑 ) 
PROMPT_COMMAND=setPrompt
PS1='\w\$ ${emoji[0]} '


# enable git bash prompt support
GIT_PROMPT_ONLY_IN_REPO=1

BASE_DIR=$(dirname ${BASH_SOURCE[0]})
if [ -f $BASE_DIR/bash-git-prompt/gitprompt.sh ]; then
    . $BASE_DIR/bash-git-prompt/gitprompt.sh
fi

alias gl='git log --branches=* --graph --decorate=short'

function getEmoji() {
  RANGE=${#emoji[@]}
  let 'RANGE += 1'
  number=$RANDOM
  let "number %= $RANGE"
  local result=${emoji[$number]}
  echo $result
}

function setPrompt() {
  emoji=$(getEmoji)
  PS1='\w\$ $emoji  '
}
