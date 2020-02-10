---
layout: page
title: test
permalink: /asm/
published: false
---
This blog is a collection of AVR assembly code developed as part of the Yale Mechatronics course for which I have been a teaching assistant since 2018.

### Generating PWM output on pins without PWM functionality

I use interrupts to generate a _pseudo_ PWM output on pin D6.
```R
pwmsetup:
; Setup the 8-bit01imer/Counter 0 to operate in Fast PWM mode
  ldi r16, 0b00000111
  sts TIMSK0, r16
  ldi r16, (0<<COM0B1)|(0<<COM0B0)|(0<<COM0A1)|(0<<COM0A0)|(1<<WGM01)|(1<<WGM00)
  out TCCR0A ,r16
  ldi r16 , (0<<WGM02)|(1<<CS02)|(0<<CS01)|(1<<CS00)
  out TCCR0B , r16
  ldi r16 , 0x2F ; sample time location between 0-255
  out OCR0A , r16
  ldi r16, 0x01 ; duty ratio for pinging
  out OCR0B, r16
ret
```

<!-- Going to add some stuff here with RPi, Arduino etc. 

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
</dl> -->
