#!/bin/bash
# shell script to prepend i3status with cmus song and artist
i3status -c ~/.i3/i3status.conf | (read line && echo $line && read line && echo $line && while :
do
  read line
  stat=$(cmus-remote -Q 2> /dev/null | grep status | cut -d ' ' -f2-)
  artist=$(cmus-remote -Q 2> /dev/null | grep ' artist ' | cut -d ' ' -f3-)
  song=$(cmus-remote -Q 2> /dev/null | grep title | cut -d ' ' -f3-)
  if [[ "$stat" != "" ]]; then
    dat="$artist - $song                  "
    if [[ "$stat" == "playing" ]]; then
      col="#c6ff00"
    elif [[ "$stat" == "paused" ]]; then
      col="#212121"
    else
      col="#ff1111"
    fi
    dat="[{ \"name\":\"music\",\"color\":\"$col\",\"full_text\":\"${dat}\" }, "
  else
    dat="["
  fi
  echo "${line/[/$dat}" || exit 1
done)
