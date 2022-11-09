.device ATmega16

// ------------ Работа с мотором ------------ //

.macro MotorControl
	setup PORTA, @0, temp
	call delay
		@1 temp
	out PORTA, temp
	call delay
		@1 temp
	out PORTA, temp
	call delay
		@1 temp
	out PORTA, temp
	call delay
.endmacro

// ------------ ----------------------- ------------ //

.include "m16def.inc"
.include "setstack.asm"
.include "setup.asm"

.def temp = r16
.def tempdelay1 = r17
.def tempdelay2 = r18

.org 0x00 
rjmp install

.org 0x02
rjmp button_one

.org 0x04
rjmp button_two

install:
setStack RAMEND, temp					//Стек
setup DDRD, 0b00000000, temp		//Настройка портов
setup DDRA, 255, temp
setup GICR, 0b11000000, temp		//Перерывания
setup MCUCR, 0, temp
sei													//Разрешение прерываний

main:	rjmp main

button_one:		MotorControl	0b00001000, ROR		//кнопка 1
reti

button_two:		MotorControl	0b00000001, ROL		//кнопка 2
reti

delay:																	//Задержка
			ldi tempdelay2, 20
	ok:	ldi tempdelay1, 51
    ok1:	dec tempdelay1
			brne ok1
			dec tempdelay2
			brne ok	ret	
