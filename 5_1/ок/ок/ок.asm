.device atmega16
.include "m16def.inc"
.def temp = r16
.org 0x00
start:
	ldi temp,low (RAMEND)
	OUT SPL,temp
	ldi r16,high (RAMEND)
	OUT SPH,temp
	ldi temp,0b11111111
	out DDRb,temp
	ldi temp,0b00000000
	out DDRd,temp

.macro Control_Diode
@2 PINB, @1
	jmp @3
	@0 portb, @1
	jmp a
.endmacro

a:
	sbis pind, 1
		jmp b
		checkr21:
			ldi r21,0
JMP A
b:
	cpi r21, 0
		BREQ c
JMP A
c:
	ldi r21,1
	sbic pind, 0
		jmp vkl3
		jmp vkl4	
jmp a

vkl3:
Control_Diode SBI, 0, SBIC, next
next:
Control_Diode SBI, 1, SBIC, next1
next1:
Control_Diode SBI, 2, SBIC, next2
next2:
Control_Diode SBI, 3, SBIC, next3
next3:
Control_Diode SBI, 4, SBIC, next4
next4:
Control_Diode SBI, 5, SBIC, next5
next5:
Control_Diode SBI, 6, SBIC, next6
next6:
Control_Diode SBI, 7, SBIC, a
jmp a

vkl4:
Control_Diode CBI, 7, SBIS, mnext
mnext:
Control_Diode CBI, 6, SBIS, mnext1
mnext1:
Control_Diode CBI, 5, SBIS, mnext2
mnext2:
Control_Diode CBI, 4, SBIS, mnext3
mnext3:
Control_Diode CBI, 3, SBIS, mnext4
mnext4:
Control_Diode CBI, 2, SBIS, mnext5
mnext5:
Control_Diode CBI, 1, SBIS, mnext6
mnext6:
Control_Diode CBI, 0, SBIS, a
jmp a