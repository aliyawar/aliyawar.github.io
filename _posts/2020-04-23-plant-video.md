---
layout: post
title: Record phototropism in plants
published: true
category: raspberry pi
---
I used [raspicam](https://www.raspberrypi.org/documentation/usage/camera/raspicam/) commands in [cron](https://www.raspberrypi.org/documentation/linux/usage/cron.md) to click still images at specified time instants.

I used [ffmpeg](https://ffmpeg.org/) to stitch the pictures together into a video and overlaid a timestamp on each frame. The timestamp is automatically generated using the frame rate and the start time of the recording. Depending on the length of the video and the size of the images, ffmpeg can take a while to finish. So, it's best to use a computer with decent amount of RAM.

```shell
# code to stitch still frames into a video with an overlaid timestamp
sudo ffmpeg -framerate 16 -pattern_type glob -i '2017-04-28_*.jpg' 
-vf drawtext="fontfile=/Library/Fonts/Arial.ttf: text='%{eif\:n*5\:d\:3} mins after 5 AM': 
fontcolor=black:fontsize=100:shadowcolor=black" output.mp4
```

<iframe width="560" height="315" src="https://www.youtube.com/embed/NqNN4nP2A40" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>