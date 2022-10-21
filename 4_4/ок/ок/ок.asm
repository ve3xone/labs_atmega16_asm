.device atmega16
.include "m16def.inc"

.def temp = r16

.org 0x00
rjmp start

.org 0x02
rjmp irq0

.org 0x1c
rjmp ADC_complete

start:
	ldi temp,low (RAMEND)
	OUT SPL,temp
	ldi r16,high (RAMEND)
	OUT SPH,temp

	ldi r16,0b00000000
	out DDRa,r16
	ldi r17,0b11111111
	out DDRb,r17
	
 	ldi temp, 0b01000000
	out GICR, temp

	ldi temp, 0b11111011
	out ADCSRA, temp

	ldi temp, 0b00100000
	out ADMUX, temp
sei

a:
sei
jmp a

irq0:
sbis PortA,0
jmp ADC_complete
cbi PortA,0
reti

ADC_complete:
	in r17, ADCH

	cpi r17,25
	brlo vikl

	cpi r17,26
	brsh vkl
reti

vkl:
	sbi portb, 0
	sbi portb, 1
reti

vikl:
	cbi portb, 0
	cbi portb, 1
reti