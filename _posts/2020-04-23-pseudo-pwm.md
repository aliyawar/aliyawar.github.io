---
layout: post
title: Generate pseudo PWM output on a non-PWM pin
category: avr programming
---
This code pertains to the ATMega320p, but can be easily ported to other microcontrollers. The ability to generate PWM output on non-PWM pins can come in handy, specially if you are working with deviced where outputs are already hardwired to the microcontroller leaving you with limited freedom to pick pins. 

The following code uses Timer/Counter 0 with the `OCR0B` match and `TCNT0` overflow interrupts enabled. 
When the `OCR0B` interrupt is called, the output on pin D6 (a non PWM pin), goes LOW. When the counter overflows, the output on D6 goes HIGH. By changing the value of the `OCR0B` match, the duty cycle of the output can be changed. The error in the output timing depends on the length of your interrupt service routines. For very low error, you can remove saving/restoring the `SREG`, taking care that the commands inside the ISRs do not affect the `SREG`.

```
pwmsetup:
; Setup the 8-bit Timer/Counter 0 to operate in Fast PWM mode
  ldi r16, 0b00000111
  sts TIMSK0, r16
  ldi r16, (0<<COM0B1)|(0<<COM0B0)|(0<<COM0A1)|(0<<COM0A0)|(1<<WGM01)|(1<<WGM00)
  out TCCR0A ,r16
  ldi r16 , (0<<WGM02)|(1<<CS02)|(0<<CS01)|(1<<CS00)
  out TCCR0B , r16
  ldi r16, 0x01 ; width of the ping
  out OCR0B, r16
ret

OCR0B_int:
  in r25, SREG ; save SREG
  cbi DDRD, 6
  cbi PORTD, 6
  out SREG , r25 ; restore SREG
reti

TCNT0_ovflow_int:
  in r23, SREG ; save SREG
  sbi DDRD, 6
  sbi PORTD, 6        
  out SREG , r23 ; restore SREG
reti
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
