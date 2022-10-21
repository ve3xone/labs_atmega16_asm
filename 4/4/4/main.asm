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

irq0:
cli
sbis PortA,0
rjmp ADC_complete
cbi PortA,0
reti

ADC_complete:
	in r17, ADCH

	cpi r17,87
	brlo vikl

	cpi r17,174
	brsh vkl

	jmp lvkl
reti

vkl:
	sbi portb, 4
	sbi portb, 5
jmp start

vikl:
	cbi portb, 4
	cbi portb, 5
jmp start

lvkl:
	sbi portb, 4
	cbi portb, 5
jmp start