//оcновная программа
 
.device ATMEGA16
.include "m16def.inc"
.org 0x00

ldi r16,low(ramend)
out spl,r16
ldi r16,high(ramend)
out sph,r16


ldi r16,0b11111111
out DDRb,r16
ldi r17,0b11111011
out DDRD,r17


ldi r23,0b00000001


loop:

	sbic PIND, 2
	jmp up
	jmp down

	up:
	//clc

	ROL r23
	out PORTb,r23
	call delay_20000mks
	call delay_20000mks
	call delay_20000mks
	call delay_20000mks
	jmp loop
	
	
	down:
		//clc
	ROR r23
	out PORTb,r23
	call delay_20000mks
	call delay_20000mks
	call delay_20000mks
	call delay_20000mks

jmp loop
	
	
delay_20000mks:
	//push r18
	//push r19
	//push r20
	//push r21
	ldi r18,  246
	ldi r19,  0b00000101
	rjmp init_delay
init_delay:
	out TCNT0, r18
	out TCCR0, r19
test_TIFR:
	in r18, TIFR
	sbrs r18,0
	rjmp test_TIFR
	ldi r20, 0b00000000
	out TCCR0, r20
	ldi r21, 0b00000001
	out TIFR,r21
	/*pop r18
	pop r19
	pop r20
	pop r21*/
ret