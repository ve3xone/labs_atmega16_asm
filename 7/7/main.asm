.device ATmega16

.include "m16def.inc"
.include "setup.asm"
.include "delay_for_lab_6_1.asm"
.include "setStack.asm"

.org 0
.def temp = r16
.def temp2 = r17

.macro SetDegree
		ldi temp, @0		//1 (+), 0(-) 
		ldi temp2, @1		//90?, 45?, 0?
		call work			//Получение инфы + задержка
.endmacro

setStack RAMEND, temp					//Стек
setup DDRD, 0b11111111, temp		//Настройка портов

setup TCCR1A, 0b10100010, temp	//ШИМ
setup TCCR1B, 0b00011010, temp
setup ICR1H, 0x09, temp
setup ICR1L, 0xc3, temp

main:
		SetDegree 1, 0b001000111	//+90?

		SetDegree 0, 175	//0?

		SetDegree 0, 125	//45?

		SetDegree 0, 75	//-90?
rjmp main

work:		call load_data
			call delay9x	reti

load_data: out OCR1AH, temp
				out OCR1AL, temp2
				out OCR1BH, temp
				out OCR1BL, temp2 reti

delay9x:		delay_for_lab_6_1 r21, 255, r20, 255
				delay_for_lab_6_1 r21, 255, r20, 255
				delay_for_lab_6_1 r21, 255, r20, 255
				delay_for_lab_6_1 r21, 255, r20, 255
				delay_for_lab_6_1 r21, 255, r20, 255
				delay_for_lab_6_1 r21, 255, r20, 255
				delay_for_lab_6_1 r21, 255, r20, 255
				delay_for_lab_6_1 r21, 255, r20, 255
				delay_for_lab_6_1 r21, 255, r20, 255 reti
