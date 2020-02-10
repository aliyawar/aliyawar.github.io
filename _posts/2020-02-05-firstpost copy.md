---
layout: post
author: Ali
title: AVR assembler pseudo PWM
---

How to output PWM on pins that have no `OCnx` output.

### Generating PWM output on pins without PWM functionality

I use interrupts to generate a _pseudo_ PWM output on pin D6.
<!-- ```R
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
``` -->