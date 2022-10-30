.device ATmega16
.include "m16def.inc"
.include "setStack.asm"
.include "setup.asm"
.include "delay_for_lab_6_1.asm"
.def temp = r16
.org 0
rjmp ssetup

.org 0x02
rjmp iqr0

.org 0x04
rjmp iqr1
 
ssetup:
	//стек
	setStack RAMEND,temp
	//порты
	setup DDRd, 0b11110000, temp
	//шим
	setup TCCR1A, 0b10100001, temp
	setup TCCR1B, 0b00001010, temp
	//кнопка
	setup GICR, 0b11100000, temp
	setup MCUCR, 0b01000000, temp
	//разрешаем прерывания
	sei

ldi r16, 0
ldi r17, 0
ldi r18, 51

main:
	out OCR1AL, r17
	out OCR1AH, r16
	out OCR1BL, r17
	out OCR1BH, r16
rjmp main

iqr0:
	cpi r17, 255
		breq exit
	call delay3x
	add r17, r18
	call delay3x
exit: reti

iqr1:
	call delay3x
	sub r17, r18
	call delay3x
reti

delay3x:
	delay_for_lab_6_1 r21, 255, r20, 255
	delay_for_lab_6_1 r21, 255, r20, 255
	delay_for_lab_6_1 r21, 255, r20, 255
ret