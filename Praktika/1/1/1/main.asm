.include "m16def.inc"
.include "setStack.asm"
.include "setup.asm"
.include "delay_and_buzzer.asm"

.def temp = r16

.org 0x00
init:
	setStack RAMEND, temp				//стек
	setup DDRa, 0b11111111, temp		//порты для 7seg
	setup DDRd, 0b11111100, temp		//порты для кнопок

start:
	sbiS PIND, 0
	jmp down0

	sbiS PIND, 1
	jmp down1

	setup PORTA, 0b00000000, temp
jmp start

down0:
	setup PORTA, 0b1001111, temp
	buzzer 239, portb, 7
jmp start

down1:
	setup PORTA, 0b1011011, temp
	buzzer 228, portb, 7 
jmp start
