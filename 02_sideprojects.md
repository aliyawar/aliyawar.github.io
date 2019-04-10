---
layout: page
title: side projects
permalink: /sideprojects/
published: false
---

Going to add some stuff here with RPi, Arduino etc. 

* Plant videos

```shell
sudo ffmpeg -framerate 16 -pattern_type glob -i '2017-04-28_*.jpg' 
-vf drawtext="fontfile=/Library/Fonts/Arial.ttf: text='%{eif\:n*5\:d\:3} mins after 5 AM': 
fontcolor=black:fontsize=100:shadowcolor=black" output.mp4
```

Probably need to upload video to youtube first.

* Janky Cat

* Wall spectrum analyzer

* Clockform

* Weather clock
* Raspicam helper for puzzle building


<dl>
<h1>processing</h1>

  <head>
      <title>Processing.js Test</title>
      <script src="../assets/processing.min.js"></script>
  </head>
  <body>
      <h1>Processing.js Test</h1>
      <p>This is my first Processing.js web-based sketch:</p>
     <canvas data-processing-sources="../assets/clockForm.pde"></canvas>
 </body>
</dl>
