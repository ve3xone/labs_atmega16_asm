.device ATMega16
.include "setstack.asm"
.include "setup.asm"
.include "delay_for_lab_6_1.asm"
.def temp = r16

.equ delay_time1 = 60
.equ delay_time2 = 60

.org 0x00
start:
	//Стек
	setStack RAMEND,temp
	//порты
	setup DDRd, 0b11111111, temp
	//шим
	setup TCCR1A, 0b10110001, temp
	setup TCCR1B, 0b00001010, temp

	ldi r16, 0
	ldi r17, 100

while_true:
out OCR1AH, r16
out OCR1AL, r17
out OCR1BH, r16
out OCR1BL, r17

inc r17
delay_for_lab_6_1 r21, 60, r20, 60

jmp while_true