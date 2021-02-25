---
layout: post
title: Generate pseudo PWM output on a non-PWM pin
category: avr programming
---
This code is written for the ATMega32u4, but it can be easily ported to other microcontrollers. The ability to generate PWM output on non-PWM pins can come in handy, specially if you are working with devices where outputs are already hardwired to the microcontroller leaving you with limited freedom to pick pins. In my case, the hardwre is the [Pololu Balboa](https://www.pololu.com/product/3575) robot. In order to use it in Assembly with the [Pololu IR reflectance array](https://www.pololu.com/docs/0J13), I needed to ping a non-PWM pin. 

This code uses Timer/Counter 0 in Fast PWM mode with the `OCR0B` match and `TCNT0` overflow interrupts enabled. When the `OCR0B` interrupt is called, the output on pin D6 (a non PWM pin), goes LOW. When the counter overflows, the output on D6 goes HIGH. By changing the value of the `OCR0B` match, the duty cycle of the output can be changed. The error in the output timing depends on the length of your interrupt service routines. For very low error, you can remove saving/restoring the `SREG`, taking care that the commands inside the ISRs do not affect the `SREG`. The frequency of the output wave can be changed by changing clock prescalars for the Timer/Counter using `CS02:0` bits in the `TCCR0B` register.

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

The following screenshots show the output waveforms at different frequencies and duty cycles. Y axis scale is 2V/div.

![](/assets/test2.png)

![](/assets/50fast.png)
*50% duty ratio, ~ 7.8 kHz*

![](/assets/6fast.png)
*6% duty ratio, ~ 7.8 kHz*

![](/assets/6slow.png)
*6% duty ratio, ~ 61 Hz*

![](/assets/50slow.png)
*50% duty ratio, ~ 61 Hz*

```
; Stack registers
.equ SPH , 0x3E
.equ SPL , 0x3D
.equ RAMEND , 0x0AFF
.equ SREG , 0x3F

.equ DIDR2, 0x7D

; Timer/Counter0 registers
.equ DDRD , 0x0A
.equ DDRB , 0x04
.equ PORTD , 0x0B
.equ PORTB , 0x05
.equ DDRC , 0x07
.equ PORTC , 0x08
.equ TCCR0A , 0x24
.equ TCCR0B , 0x25
.equ OCR0A , 0x27
.equ OCR0B, 0x28
.equ TIMSK0, 0x6E

.equ D6 , 6

; TCCR0A bits
.equ COM0A1 , 7
.equ COM0A0 , 6
.equ COM0B1 , 5
.equ COM0B0 , 4
.equ WGM01 , 1
.equ WGM00 , 0

; TCCR0B bits
.equ WGM02 , 3
.equ CS02 , 2
.equ CS01 , 1
.equ CS00 , 0

.org 0x0000
    rjmp reset; Power on interrupt 
.org 0x58
    rjmp OCR0B_int
.org 0x5c
   rjmp TCNT0_ovflow_int 
.org 0xAC; The vector table would end here if all interrupts are used

reset:
    ldi r16 , hi8(RAMEND)
    out SPH , r16
    ldi r16 , lo8(RAMEND)
    out SPL , r16
    rcall pwmsetup
    ;rcall adcsetup
    ;rcall analogoutsetup
    sei

main:
  rjmp main

pwmsetup:
; Setup the 8-bit Timer/Counter 0 to operate in Fast PWM mode
  ldi r16, 0b00000101
  sts TIMSK0, r16
  ldi r16, (0<<COM0B1)|(0<<COM0B0)|(0<<COM0A1)|(0<<COM0A0)|(1<<WGM01)|(1<<WGM00)
  out TCCR0A ,r16
  ldi r16 , (0<<WGM02)|(1<<CS02)|(0<<CS01)|(1<<CS00)
  out TCCR0B , r16
  ldi r16, 0x20 ; width of the ping
  out OCR0B, r16
ret

OCR0B_int:
  ; For these two interrupts, I could afford to sacrifice the memory registers 
  ; exclusively for saving and restoring SREG. They must not be used elsewhere 
  ; in the code. If registers cannot be exclusive, they must be pushed to the stack 
  ; before anything else happens in the ISR.
  in r25, SREG ; save SREG
  ldi r17, 0b00000000
  ldi r19, 0b01000000
  out DDRD, r19
  out PORTD, r17
  out SREG , r25 ; restore SREG
reti

TCNT0_ovflow_int:
  in r23, SREG ; save SREG
  ldi r18, 0b01000000
  out DDRD, r18
  out PORTD, r18         
  out SREG , r23 ; restore SREG
reti
```

**Acknowledgement**: I learned the basics of microcontroller programming in assembly as a Teaching Assistant for Yale's Mechatronics Course ([MENG 390](https://courses.yale.edu/?details&srcdb=202101&crn=23090)). This code is based on code skeletons originally developed by the course instructor.