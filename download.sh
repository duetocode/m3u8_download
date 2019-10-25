#!/bin/bash

COUNTER=1

# 要跳过的片段数量（用于中断后继续下载）
SKIP=${2:0}
export all_proxy=socks5://127.0.0.1:1086

mkdir -p ts

while IFS="" read -r p || [ -n "$p" ]
do
  target="ts/$COUNTER.ts"
  echo $COUNTER $target

  if [ $SKIP -gt $COUNTER ] || [ -f $target ]; then
    echo 'SKIP'
    COUNTER=$[COUNTER + 1]
  else 
    tmp="ts/.$COUNTER.ts.tmp"
    curl -L -o "$tmp" "$p"
    if [ "$?" -eq "0" ]; then
        mv $tmp $target
        COUNTER=$[COUNTER + 1]
    else
        echo "Retry"
    fi
  fi
done < $1;

echo 'All pieces have been downloaded.'


