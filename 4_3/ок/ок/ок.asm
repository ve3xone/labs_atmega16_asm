.device atmega16
.include "m16def.inc"

.def temp = r16

.org 0x00
rjmp start

.org 0x02
rjmp irq0

.org 0x1c
rjmp ADC_complete

.macro vkl_adc
ldi temp, @0
out ADCSRA, temp
ldi temp, 0b00100000
out ADMUX, temp
.endmacro

start:
	ldi temp,low (RAMEND)
	OUT SPL,temp

	ldi temp,high (RAMEND)
	OUT SPH,temp

	ldi temp,0b00000000
	out DDRa,temp
	ldi temp,0b11111111
	out DDRb,temp
	
	ldi temp, 0b01000000
	out GICR, temp

	ldi temp, 0b00000000
	out MCUCR, temp

	vkl_adc	  0b11111011
sei

ldi r22,1
a:
sei
jmp a

irq0:
jmp vkl2
okexitcomlite:
reti

ADC_complete:
in r17, ADCH

	cpi r17,169
	brsh vkl

	jmp lvkl
reti

vkl:
	cpi r22,1
	BREQ OK2
	
	jmp vkl3
vklexit:
reti

lvkl:
	Cbi portb, 6
	cbi portb, 7
reti

vkl2:
	ldi r22, 0
	sbiS pinb, 6
		jmp OK
		Cbi portb, 6
	Sbi portb, 7
okexit:
jmp okexitcomlite

OK:
ldi r22, 1
Sbi portb, 6
Sbi portb, 7
JMP okexit

OK2:
ldi r22, 1
Sbi portb, 6
Sbi portb, 7
jmp vklexit

vkl3:
ldi r22, 0
	cbi portb, 6
	Sbi portb, 7
jmp vklexit