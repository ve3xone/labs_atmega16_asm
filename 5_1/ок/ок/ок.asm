.device atmega16

.include "m16def.inc"
.include "Control_Diode.asm"
.include "setStack.asm"
.include "setup.asm"
.include "encoder_check.asm"

.def temp = r16
.def portinstalltemp = r17
.def encodercheck = r18

.org 0x00
start:
	setStack RAMEND,temp
	setup DDRb, 0b11111111, temp
	setup DDRd, 0b00000000, temp
	setup PORTB, 0b00000001, portinstalltemp

a: encoder_check pind, 1, pind, 0, encodercheck, jmp a, jmp plus, jmp minus	
jmp a
minus: Control_Diode ROR, 0b10000000, sevenROR, portinstalltemp, jmp a
plus: Control_Diode ROL, 0b00000010, sevenROL, portinstalltemp, jmp a
