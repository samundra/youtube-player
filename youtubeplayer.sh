#!/bin/bash
# Play and download the youtube video simultaneously
# Author: Samunddra
# Update Date: 2016-12-14 16:29:14 PM
# 
# Use `screen` to play it in the background, fork screen process and exit, enjoy
#
# DEPENDENCIES
#   - sudo apt install -y jq mplayer youtube-dl
#
# Usage: ./videoplayer.sh 'youtube-playlist-link'
#
# TODO
# 1. Show the title of the currently playing video
#
set -e

APPLICATION_HOME="/home/$USER/ytplayer"

# Create Application home if it do not exists
[ ! -d "$APPLICATION_HOME" ] && mkdir -p $APPLICATION_HOME

FILENAME="$APPLICATION_HOME/video-list.txt"
VIDEOLOG="$APPLICATION_HOME/video-log.txt"
SUFFIX=`date | cut -d " " -f4|sed 's/:/_/g'`

echo >> $FILENAME;
echo "Requested URL: $1" >> $VIDEOLOG;

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

    youtube-dl -o - "$url"| tee "$APPLICATION_HOME/video_${SUFFIX}_$i.webm"| \
        mplayer -vo xv -noborder -ontop -vf scale=320:240 \
        -geometry 2%:98% -screenw 240 -screenh 320 -quiet -

    (( i = i + 1))
done

notify-send "Playlist Completed" \
    "End of the playlist reached." \
    -i /usr/share/pixmaps/linssid-start.png \
    -t 0
