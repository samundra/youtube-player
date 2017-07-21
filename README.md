### Borderless Youtube Player

Use `screen` to play it in the background
- fork screen process and detach it and enjoy the borderless video
- OR run the videoplayer and keep the terminal window open
- let it play and monitor the progress :)

#### SCREENSHOT
![Youtube Player](https://user-images.githubusercontent.com/760855/28559384-835384c8-7140-11e7-8b37-056d84403301.png)

### BACKGROUND
I was looking for borderless youtube video player and didn't find
anything that worked on linux.
- some suggested to use VLC and tweak the WM to remove the border. I
  tried it but didn't work for me.
- compiz doesn't seem to work with application window border so well.

### How I came with it?
I already knew about the mplayer and also I already knew about the
youtube-dl. After thinking and playing around for a while with mplayer
settings I got the borderless video. I just had to tweak around the
settings that worked for me. The size of video window and the display
settings. After I found the settings that worked for me, the remaining
thing was to pull the videos from youtube and play it in the desktop :)

### DEPENDENCIES
| application | usuage                                                               |
|-------------|----------------------------------------------------------------------|
| youtube-dl  | downloads the youtube videos and lets you stream directly from stdin |
| mplayer     | play the borderless video                                            |
| jq          | used to parse the json, and extract youtube video links              |

### DEPENDENCIES INSTALLATION
```bash
$ sudo apt install -y jq mplayer youtube-dl
```

### USAGE
```bash
$ git clone git@github.com:samundra/youtube-player.git
$ cd youtube-player
$ chmod +x youtubeplayer.sh
$ ./youtubeplayer.sh {youtube-playlist-link}
```

#### Usage on Playlist
```bash
$ ./youtubeplayer.sh 'https://www.youtube.com/watch?v=AnBQXaC1ulQ&list=PL51x_HtQrp9Fei1JgRHdBz4DG2ARkNlT0'
```

#### Usage on Single Video
```bash
$ ./youtubeplayer.sh 'https://www.youtube.com/watch?v=tLyw7jytykE'
```

#### Sample output as you start to play the video with the above command
```bash
MPlayer 1.2.1 (Debian), built with gcc-5.3.1 (C) 2000-2016 MPlayer Team
mplayer: could not connect to socket
mplayer: No such file or directory
Failed to open LIRC support. You will not be able to use your remote control.

Playing -.
Reading from stdin...
libavformat version 56.40.101 (external)
[youtube] tLyw7jytykE: Downloading webpage
[youtube] tLyw7jytykE: Downloading video info webpage
[youtube] tLyw7jytykE: Extracting video information
[youtube] tLyw7jytykE: Downloading MPD manifest
[download] Destination: -
[download]   0.1% of 12.22MiB at  4.91MiB/s ETA 00:02libavformat file format detected.
[download]   1.0% of 12.22MiB at  1.75MiB/s ETA 00:06[mov,mp4,m4a,3gp,3g2,mj2 @ 0x7f0d97902d80]Protocol name not provided, cannot determine if input is local or a network protocol, buffers and access patterns cannot be configured optimally without knowing the protocol
[lavf] stream 0: video (h264), -vid 0
[lavf] stream 1: audio (aac), -aid 0, -alang und
VIDEO:  [H264]  640x360  24bpp  25.000 fps  544.0 kbps (66.4 kbyte/s)
Clip info:
 major_brand: mp42
 minor_version: 0
 compatible_brands: isommp42
 creation_time: 2015-04-07 05:35:39
Load subtitles in ./
Opening video filter: [scale w=320 h=240]
==========================================================================
Opening video decoder: [ffmpeg] FFmpeg's libavcodec codec family
libavcodec version 56.60.100 (external)
Selected video codec: [ffh264] vfm: ffmpeg (FFmpeg H.264)
==========================================================================
==========================================================================
Opening audio decoder: [ffmpeg] FFmpeg/libavcodec audio decoders
AUDIO: 44100 Hz, 2 ch, floatle, 96.0 kbit/3.40% (ratio: 12002->352800)
Selected audio codec: [ffaac] afm: ffmpeg (FFmpeg AAC (MPEG-2/MPEG-4 Audio))
==========================================================================

```

Sit back and enjoy the video.

### TIPS AND TRICKS
- The video window is mplayer window. That means, you can click on it and
  the use the shortcuts that you use in mplayer.

#### Shortcuts

| Shortcuts | What it does |
|-----------|--------------|
| q | quit the currently playing video, as soon as the current video finishes the next on the playlist will start to play automatically |
| space | Pause the video |
| shift + T | Enable/Disable Stick on Top option |
| m | Mute the video |

### TODO
- Display title of the currently playing video
- When current video is finished and it starts to play next video, it
steals focus to itself, which is annoying when we are focused on doing other tasks.

### CONTRIBUTIONS
- Please feel free to ```fork it``` make changes to your heart's content when you
are happy send a PR to this repository.
- It's a bash script, so there's no specific guidelines other than the bash script
guidlines.
