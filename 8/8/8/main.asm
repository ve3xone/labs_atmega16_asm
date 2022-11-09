.device ATmega16

// ------------ ������ � ������� ------------ //

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
setStack RAMEND, temp					//����
setup DDRD, 0b00000000, temp		//��������� ������
setup DDRA, 255, temp
setup GICR, 0b11000000, temp		//�����������
setup MCUCR, 0, temp
sei													//���������� ����������

main:	rjmp main

button_one:		MotorControl	0b00001000, ROR		//������ 1
reti

button_two:		MotorControl	0b00000001, ROL		//������ 2
reti

delay:																	//��������
			ldi tempdelay2, 20
	ok:	ldi tempdelay1, 51
    ok1:	dec tempdelay1
			brne ok1
			dec tempdelay2
			brne ok	ret	
