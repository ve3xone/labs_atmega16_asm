.device ATMEGA16
.include "m16def.inc"
.org 0x00

.def iLoopRl = r24
.def iLoopRh = r25
.def loopCt = r18

//калибровка 67998
.equ iVal = 71500

ldi r19,LOW(RAMEND)
out SPL,r19
ldi r19, HIGH(RAMEND)
out SPL,r19

ldi r17,0
ldi r16,0b00010000
out DDRA,r16
nop

.macro delayms
push r18
push r24
push r25

ldi r18,@0/10
rcall delay10ms


pop r25
pop r24
pop r18
.endmacro

loop:
	eor r17,r16
	out PORTA,r17
	delayms 10
jmp loop

delay10ms:
	ldi iLoopRl,LOW(iVal)
	ldi iLoopRh,HIGH(iVal)
iLoop: sbiw iLoopRl,1
	brne iLoop

	dec loopCt
	brne delay10ms

	nop

	ret