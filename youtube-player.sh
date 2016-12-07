#!/bin/bash
# 
# Author: Samunddra
# Date: 2016-12-08 01:45:34 AM
# 
# Use `screen` to play it in the background, fork screen process and exit, enjoy
#
# Usage: ./youtube-player.sh 'https://www.youtube.com/watch?v=WsptdUFthWI&list=PLwpFrtWg2EJFsZK90YBdU1PNei0Hfo0lb'
#

set -e

FILENAME='/home/samundra/video-list-1.txt'
VIDEOLOG='/home/samundra/video-log-1.txt'

echo >> $FILENAME;
echo >> $VIDEOLOG;

# https://zhimingwang.org/blog/2014-11-05-list-youtube-playlist-with-youtube-dl.html
youtube-dl -j --flat-playlist "$1"| jq -r '.id' | \
sed 's_^_https://youtube.com/v/_' > $FILENAME

TOTAL_VIDEOS=`cat $FILENAME|nl|sort -rn|xargs|cut -f1 -d " "`
TOTAL_VIDEOS=$TOTAL_VIDEOS|awk '{print $0}'

echo "TOTAL VIDEOS FOUND: $TOTAL_VIDEOS" >> $VIDEOLOG

URLS=`cat $FILENAME|xargs`

i=1

while [[ $i -le $TOTAL_VIDEOS ]]

do
    url=`cat $FILENAME|xargs|cut -f$i -d " "`;

    echo "Currently Playing: $url" >> $VIDEOLOG
    
    notify-send "Youtube Player" \
        "Playing index : $i, $url" \
        -i /usr/share/pixmaps/linssid-start.png \
        -t 10000

    youtube-dl -o - "$url"|mplayer -vo xv -noborder -ontop -vf scale=320:240 \
    -geometry 2%:98% -screenw 240 -screenh 320 -quiet -

    (( i = i + 1))
done

echo 'Playlist Completed';
